<template>
    <v-container>
        <notificationGroup group="top">
            <div class="fixed inset-0 flex px-4 py-6 pointer-events-none p-6 items-start justify-end">
                <div class="max-w-sm w-full">
                    <notification v-slot="{notifications}">
                        <div
                                class="flex max-w-sm w-full mx-auto bg-white shadow-md rounded-lg overflow-hidden mt-4"
                                v-for="notification in notifications"
                                :key="notification.id"
                        >
                            <div class="flex justify-center items-center w-12 bg-green-500">
                                <svg
                                        class="h-6 w-6 fill-current text-white"
                                        viewBox="0 0 40 40"
                                        xmlns="http://www.w3.org/2000/svg"
                                >
                                    <path
                                            d="M20 3.33331C10.8 3.33331 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6666 20 36.6666C29.2 36.6666 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33331 20 3.33331ZM16.6667 28.3333L8.33337 20L10.6834 17.65L16.6667 23.6166L29.3167 10.9666L31.6667 13.3333L16.6667 28.3333Z"
                                    ></path>
                                </svg>
                            </div>

                            <div class="-mx-3 py-2 px-4">
                                <div class="mx-3">
                                    <span class="text-green-500 font-semibold">{{notification.title}}</span>
                                    <p class="text-gray-600 text-sm">{{notification.text}}</p>
                                </div>
                            </div>
                        </div>
                    </notification>
                </div>
            </div>
        </notificationGroup>
        <v-row align="center" justify="center">
            <v-col cols="12" sm="6" md="6" lg="4">
                <v-img class="fill-height" :src="require('../src/assets/logo.png')" aspect-ratio="6"></v-img>
            </v-col>
        </v-row>
        <v-row align="center" justify="center">
            <v-col cols="12" sm="8" md="6" lg="4">
                <v-card class="elevation-12">
                    <v-spacer></v-spacer>
                    <v-card-text>
                        <v-form>
                            <v-text-field
                                    v-bind:label="$t('input.loginLabel')"
                                    name="login"
                                    prepend-icon="mdi-account"
                                    type="text"
                                    v-model="email"
                            ></v-text-field>

                            <v-text-field
                                    id="password"
                                    v-bind:label="$t('input.passwordLabel')"
                                    name="password"
                                    prepend-icon="mdi-lock"
                                    type="password"
                                    v-model="password"
                            ></v-text-field>
                        </v-form>
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn to="/signup" color="error">{{ $t("button.sign_up") }}</v-btn>
                        <v-btn @click="signIn" color="primary">{{ $t("button.login") }}</v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import gql from 'graphql-tag'
    import "tailwindcss/dist/tailwind.css";

    export default {
        data() {
            return {
                email: '',
                password: '',
            }
        },
        methods: {
            signIn () {
                this.$apollo.mutate({
                    client: 'auth',
                    mutation: gql`
                                        mutation userLogin($email: String!, $password: String!)
                                       {
                                            userLogin(
                                                    email: $email,
                                                    password: $password
)
                                            {
                                                user { id email firstName lastName }
                                                credentials { accessToken uid tokenType client expiry }
                                            }
                                       }
                                    `,
                    variables: {
                        email: this.email,
                        password: this.password
                    }
                })
                    .then(response => this.successSignIn(response))
                    .catch(error => this.failedSignIn(error))
            },
            successSignIn(response) {
                this.$store.commit('setCurrentUser', {user: response.data.userLogin.user, credentials: response.data.userLogin.credentials});
                this.$router.go('/task_list')
            },
            failedSignIn() {
                // TODO
            }
        }
    }
</script>

<style>
</style>