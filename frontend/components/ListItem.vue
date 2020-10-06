<template>
    <v-expansion-panel>
        <v-expansion-panel-header>
            <v-row>
                <v-col cols="12" sm="11">
                    {{ list.title }}
                </v-col>
                <v-col cols="12" sm="1">
                    <v-btn @click.native.stop :key="list.id" @click="$emit('destroy-list')" small outlined color="error" >
                        <v-icon>mdi-delete</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-expansion-panel-header>

        <v-expansion-panel-content>
            <v-text-field
                    v-model="jobTitle"
                    v-bind:placeholder="$t('placeholders.addJob')"
                    @keydown.enter="addJob(list.id)"
                    autocomplete="off"
                    clearable
                    color="green"
                    flat
                    hide-details>
            </v-text-field>
            <jobs-list :jobs="currentJobs" :key="list.id"></jobs-list>
        </v-expansion-panel-content>
    </v-expansion-panel>
</template>

<script>
    import JobItem from "../components/JobItem";
    import gql from 'graphql-tag'

    export default {
        name: "ListItem",
        props: ['list', 'jobs'],
        data: function () {
            return {
                jobTitle: '',
                currentJobs: this.jobs
            }
        },
        components: {
            'jobs-list': JobItem
        },
        methods: {
            addJob(list_id) {
                this.$apollo.mutate({
                    mutation: gql`
                                        mutation createJob($listId: ID! $title: String!)
                                            {
                                                createJob(
                                                    listId: $listId
                                                    title: $title
                                                )
                                            {
                                               id title status
                                            }
                                       }
                                    `,
                    variables: {
                        listId: list_id,
                        title: this.jobTitle
                    }
                }).then(response => {
                    this.currentJobs.push(response.data.createJob)
                }).catch(error => {
                    // TODO
                })
            },
        }
    };
</script>