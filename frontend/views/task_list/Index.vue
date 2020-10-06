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
                        color="green"
                        flat
                        hide-details>
                </v-text-field>

                <v-spacer></v-spacer>

                <v-btn @click="signOut" small outlined color="error">
                    Exit
                    <v-icon>mdi-exit-run</v-icon>
                </v-btn>

            </v-toolbar>
        </v-card>

        <v-card class="mt-4" v-if="lists.length">
            <v-expansion-panels v-for="(list, index) in lists" :key="list.id" class="pt-2 pb-2 pl-2 pr-2" multiple>
                <ListItem :key="list.id" :list="list" :jobs="list.jobs" v-on:destroy-list="destroyList(list.id, index)"></ListItem>
            </v-expansion-panels>
            <v-spacer></v-spacer>
        </v-card>
    </v-container>
</template>

<script>
    import gql from 'graphql-tag'
    import { NetworkStatus } from 'apollo-boost';
    import ListItem from '../../components/ListItem.vue'

    export default {
        data: () => ({
            lists: [],
            listTitle: '',
        }),
        components: {ListItem},
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
            }
        }
    }
</script>