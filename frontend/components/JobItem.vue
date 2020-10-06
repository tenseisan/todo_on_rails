<template>
    <v-simple-table>
        <thead>
        <tr>
            <th class="text-left">
                <v-checkbox @click="selectAll" v-model="checkAll"
                            color="success"
                            hide-details>
                </v-checkbox>
            </th>
            <th class="text-left">{{$t('job.title')}}</th>
            <th class="text-left">{{$t('job.status')}}</th>
            <th class="text-left">{{$t('job.delete')}}</th>
            <th class="text-left">{{$t('job.complete')}}</th>
        </tr>
        </thead>
        <tbody>
            <tr v-for="(job, index) in currentJobs" :key="job.id">
                <td>
                    <v-checkbox @change='updateCheckAll' v-model="selected" :value="job.id"
                                color="success"
                                hide-details>
                    </v-checkbox>
                </td>
                <td>{{ job.title }}</td>
                <td>{{ $t('job.statusData.' + job.status.toLowerCase()) }}</td>
                <td>
                    <v-btn @click="destroyJob(job.id, index)" small outlined color="error" >
                        <v-icon>mdi-delete</v-icon>
                    </v-btn>
                </td>
                <td>
                    <v-btn :disabled="job.status === 'COMPLETED'" @click="completeJob" small outlined color="green" >
                        <v-icon>mdi-check</v-icon>
                    </v-btn>
                </td>
            </tr>

        </tbody>
    </v-simple-table>
</template>

<script>
    import gql from 'graphql-tag'

    export default {
        name: "JobItem",
        data: function () {
            return {
                currentJobs: this.jobs,
                selected: [],
                checkAll: false
            }
        },
        props: ['jobs'],
        methods: {
            selectAll() {
                this.selected = [];
                if(this.checkAll){
                    for (let item in this.currentJobs) {
                        this.selected.push(this.currentJobs[item].id);
                    }
                }
            },
            updateCheckAll() {
                (this.selected.length === this.currentJobs.length) ? this.checkAll = true : this.checkAll = false;
            },
            completeJob() {
                // TODO
            },
            destroyJob(id, index) {
                this.$apollo.mutate({
                    mutation: gql`
                                 mutation destroyJob($id: ID!)
                                    {
                                        destroyJob(
                                            id: $id
                                        )
                                        {
                                           id
                                        }
                                   }
                                 `,
                    variables: {
                        id: id
                    }
                }).then(response => {
                    this.currentJobs.splice(index, 1)
                }).catch(error => {
                    // TODO
                })
            },
        }
    };
</script>

<style>

</style>