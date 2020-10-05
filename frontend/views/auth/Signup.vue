<template>
    <v-container>
        <v-row align="center" justify="center">
            <v-col cols="12" sm="6" md="6" lg="4">
                <v-img class="fill-height" :src="require('@/assets/logo.png')" aspect-ratio="6"></v-img>
            </v-col>
        </v-row>
        <v-row align="center" justify="center">
            <v-col cols="12" sm="8" md="6" lg="4">
                <v-card class="elevation-12">
                    <v-alert v-if="response.message" type="error">
                        {{ response.message }}
                    </v-alert>
                    <v-spacer></v-spacer>
                    <v-card-text>
                        <v-form id="sign-up-form">
                            <v-text-field
                                    v-bind:label="$t('input.emailLabel')"
                                    v-model="email"
                                    name="email"
                                    :error-messages="emailErrors"
                                    prepend-icon="mdi-account"
                                    type="text"
                                    required
                                    @input="$v.email.$touch()"
                                    @blur="$v.email.$touch()"
                            ></v-text-field>
                            <v-text-field
                                    v-bind:label="$t('input.firstNameLabel')"
                                    v-model="firstName"
                                    name="firstName"
                                    :error-messages="firstNameErrors"
                                    prepend-icon="mdi-account"
                                    type="text"
                                    required
                                    @input="$v.firstName.$touch()"
                                    @blur="$v.firstName.$touch()"
                            ></v-text-field>
                            <v-text-field
                                    v-bind:label="$t('input.lastNameLabel')"
                                    v-model="lastName"
                                    name="lastName"
                                    :error-messages="lastNameErrors"
                                    prepend-icon="mdi-account"
                                    type="text"
                                    required
                                    @input="$v.lastName.$touch()"
                                    @blur="$v.lastName.$touch()"
                            ></v-text-field>
                            <v-text-field
                                    id="password"
                                    v-model="password"
                                    v-bind:label="$t('input.passwordLabel')"
                                    name="password"
                                    :error-messages="passwordErrors"
                                    prepend-icon="mdi-lock"
                                    type="password"
                                    required
                                    @input="$v.password.$touch()"
                                    @blur="$v.password.$touch()"
                            ></v-text-field>
                            <v-text-field
                                    id="passwordConfirmation"
                                    v-model="passwordConfirmation"
                                    v-bind:label="$t('input.passwordConfirmationLabel')"
                                    name="passwordConfirmation"
                                    :error-messages="passwordConfirmationErrors"
                                    prepend-icon="mdi-lock"
                                    type="password"
                                    @input="$v.passwordConfirmation.$touch()"
                                    @blur="$v.passwordConfirmation.$touch()"
                            ></v-text-field>
                        </v-form>
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn to="/signup" type="submit" @click="signUp" color="error">{{ $t("button.signUpConfirm") }}</v-btn>
                        <v-btn to="/" color="primary">{{ $t("button.return") }}</v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import { validationMixin } from 'vuelidate'
    import { required, email, sameAs, minLength } from 'vuelidate/lib/validators'
    import gql from 'graphql-tag'

    export default {
        mixins: [validationMixin],

        validations: {
            email: { required, email },
            firstName: { required },
            lastName: { required },
            password: { required, minLength: minLength(6) },
            passwordConfirmation: { sameAsPassword: sameAs('password') }
        },
        data() {
          return {
              email: '',
              firstName: '',
              lastName: '',
              password: '',
              passwordConfirmation: '',
              response: {
                  message: null
              }
          }
        },
        computed :{
            emailErrors () {
                const errors = [];
                if (!this.$v.email.$dirty) return errors;
                !this.$v.email.email && errors.push(this.$t('errors.emailInvalid'));
                !this.$v.email.required && errors.push(this.$t('errors.emailRequired'));
                return errors
            },
            firstNameErrors () {
                const errors = [];
                if (!this.$v.firstName.$dirty) return errors;
                !this.$v.firstName.required && errors.push(this.$t('errors.firstNameRequired'));
                return errors
            },
            lastNameErrors () {
                const errors = [];
                if (!this.$v.lastName.$dirty) return errors;
                !this.$v.lastName.required && errors.push(this.$t('errors.lastNameRequired'));
                return errors
            },
            passwordErrors () {
                const errors = [];
                if (!this.$v.password.$dirty) return errors;
                !this.$v.password.required && errors.push(this.$t('errors.passwordRequired'));
                !this.$v.password.minLength && errors.push(this.$t('errors.passwordMinLength'));
                return errors
            },
            passwordConfirmationErrors () {
                const errors = [];
                if (!this.$v.passwordConfirmation.$dirty) return errors;
                !this.$v.passwordConfirmation.sameAsPassword && errors.push(this.$t('errors.sameAs'));
                return errors
            }
        },
        methods: {
            signUp() {
                    this.$apollo.mutate({
                        client: 'auth',
                        mutation: gql`
                                        mutation userSignUp($firstName: String!, $lastName: String!, $email: String!, $password: String!, $passwordConfirmation: String!)
                                       {
                                            userSignUp(
                                                    firstName: $firstName, lastName: $lastName, email: $email,
                                                    password: $password, passwordConfirmation: $passwordConfirmation
)
                                            {
                                                credentials { accessToken }
                                            }
                                       }
                                    `,
                        variables: {
                            firstName: this.firstName,
                            lastName: this.lastName,
                            email: this.email,
                            password: this.password,
                            passwordConfirmation: this.passwordConfirmation
                        }
                    })
                        .then(this.successSignUp)
                        .catch(error => this.failedSignUp(error))
            },
            successSignUp() {
                this.$router.replace('/')
                this.$notify(
                    {
                        group: "top",
                        title: this.$t('notifications.success'),
                        text: this.$t('notifications.successSignUp')
                    },
                    1500
                );
            },
            failedSignUp(error) {
                this.response.message = error.message
            }
        },
    }
</script>

<style>
</style>