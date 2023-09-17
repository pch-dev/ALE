<template>
    <v-row class="d-flex justify-center">
        <v-col cols="auto">
            <div>Question {{ question.id }}. {{ question.question }}</div>
            <v-radio-group
              v-model="selectedAnswer"
              column
              class="pa-4"
            >
              <v-radio
                v-for="option in question.options"
                :label="option.label"
                :color="option.value == question.correctAnswer ? 'success' : 'error'"
                :value="option.value"
                :disabled="option.isDisabled"
              ></v-radio>
            </v-radio-group>
            <template v-if="selectedAnswer != ''">
                <v-row>
                    <v-col>
                        <v-alert
                            :color="selectedAnswer === question.correctAnswer ? 'success' : 'error'"
                            :icon="selectedAnswer === question.correctAnswer ? '$success' : '$error'"
                            :title="selectedAnswer === question.correctAnswer ? 'Correct!' : 'Wrong answer!'"
                            :text="selectedAlertMessage"
                        ></v-alert>
                    </v-col>
                </v-row>
                <v-row v-if="selectedAnswer === question.correctAnswer">
                    <v-col>
                        <v-btn 
                            v-if="isFinalQuestion"
                            @click="proceed()"
                            variant="outlined"
                            color="secondary"
                        >
                            Proceed
                        </v-btn>
                        <v-btn 
                            v-else
                            @click="nextQuestion()"
                            variant="outlined"
                            color="primary"
                        >
                            Next question
                        </v-btn>
                    </v-col>
                </v-row>
            </template>
        </v-col>
    </v-row>
</template>
<script setup>
  import { computed } from 'vue'
</script>
<script>

export default {
    name: "Question",
    props: ['question', 'isFinalQuestion'],
    data() {
        return {
            selectedAnswer: '',
            selectedAlertMessage: computed(() => this.question.options.find(o => o.value === this.selectedAnswer).alertMessage)
        }
    },
    methods: {
        nextQuestion() {
            this.$emit("correctAnswer");
        },
        proceed() {
            this.$emit("proceed")
        }
    }
}
</script>