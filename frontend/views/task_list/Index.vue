<template>
    <v-container>
        <v-card>
            <v-toolbar dense>
                <v-text-field
                        v-model="listTitle"
                        v-bind:placeholder="$t('placeholders.addList')"
                        @keydown.enter="addList"
                        autofocus
                        autocomplete="off"
                        clearable
                        color="primary"
                        flat
                        hide-details
                ></v-text-field>
                <v-spacer></v-spacer>
                <v-btn @click="signOut" small outlined color="error" >
                    Exit
                    <v-icon>mdi-exit-run</v-icon>
                </v-btn>
            </v-toolbar>
        </v-card>
        <v-card class="mt-4">
            <v-expansion-panels v-if="lists.length" class="pt-2 pb-2" popout multiple accordion>
                <v-expansion-panel v-for="(list, index) in lists" :key="list.id">
                    <v-expansion-panel-header>
                        <v-row>
                            <v-col cols="12" sm="11">
                                {{ list.title }}
                            </v-col>

                            <v-col cols="12" sm="1">
                                <v-btn @click.native.stop :key="list.id" @click="destroyList(list.id, index)" small outlined color="error" >
                                    <v-icon>mdi-delete</v-icon>
                                </v-btn>
                            </v-col>
                        </v-row>
                    </v-expansion-panel-header>
                    <v-expansion-panel-content>
                        <v-list>
                            <v-text-field
                                    v-model="jobTitle"
                                    v-bind:placeholder="$t('placeholders.addJob')"
                                    @keydown.enter="addJob(list.id)"
                                    autocomplete="off"
                                    clearable
                                    color="primary"
                                    flat
                                    hide-details
                            ></v-text-field>
                            <v-list-item-group v-if="list.jobs.length">
                                <v-list-item v-for="(job, index) in list.jobs" :key="job.id" >
                                    <v-list-item-action>
                                        <v-checkbox
                                                color="green" v-model="job.status"></v-checkbox>
                                    </v-list-item-action>
                                    <v-list-item-content>
                                        <v-list-item-title v-text="job.title"></v-list-item-title>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-list-item-group>
                            <v-list-item-group v-else>
                                <div v-text="$t('messages.noJob')" class="text-h7 mt-4 text-center"></div>
                            </v-list-item-group>
                        </v-list>
                    </v-expansion-panel-content>
                </v-expansion-panel>
            </v-expansion-panels>
            <v-spacer></v-spacer>
        </v-card>
    </v-container>
</template>

<script>
    import gql from 'graphql-tag'
    import { NetworkStatus } from 'apollo-boost';

    export default {
        data: () => ({
            lists: [],
            newTodo: '',
            listTitle: '',
            jobTitle: '',
            jobStatus: '',
        }),
        apollo: {
            lists: {
                query:
                    gql`query lists
                         {
                            lists {
                              id
                              title
                              jobs {
                                id
                                title
                                status
                              }
                            }
                        }`,
                result(response, _) {
                    if (response.networkStatus === NetworkStatus.error) {
                        this.$store.commit('unsetCurrentUser')
                        this.$router.go('/')
                    }
                }
            }
        },
        methods: {
            signOut() {
                this.$apollo.mutate({
                    client: 'auth',
                    mutation: gql`
                                        mutation userLogout
                                       {
                                            userLogout
                                            {
                                                authenticatable { email }
                                            }
                                       }
                                    `
                })
                this.$store.commit('unsetCurrentUser')
                this.$router.go('/')
            },
            addList() {
                const title = this.listTitle.trim()
                if (title) {
                    this.$apollo.mutate({
                        mutation: gql`
                                mutation
                                    createList($title: String!) {
                                        createList(title: $title) {
                                            id title jobs { id title status }
                                        }
                                    }

                                `,
                        variables: {
                            title: this.listTitle
                        }
                    }).then(response => {
                        this.lists.push(response.data.createList)
                       })
                }
            },
            destroyList(id, index) {
                this.$apollo.mutate({
                    mutation: gql`
                                mutation
                                    destroyList($id: ID!) {
                                        destroyList(id: $id) {
                                            id title
                                        }
                                    }

                                `,
                    variables: {
                        id: id
                    }
                }).then(
                    this.lists.splice(index, 1)
                )
            },
            addJob(list_id) {
                this.$apollo.mutate({
                    mutation: gql`
                                        mutation createJob($list_id: String!)
                                            {
                                                createJob(
                                                    list_id: $list_id
                                                )
                                            {
                                                list { id title }
                                            }
                                       }
                                    `,
                    variables: {
                        list_id: list_id
                    }
                }).then(response => {
                    // TODO
                }).catch(error => {
                    // TODO
                })
            },
            destroyJob(id, index) {

            }
        }
    }
</script>

<style>
</style>