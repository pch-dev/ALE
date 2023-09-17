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
                :color="option.value == question.correctAnswer ? 'success' : isAnyAnswer ? 'info' : 'error'"
                :value="option.value"
                :disabled="option.isDisabled"
              ></v-radio>
            </v-radio-group>
            <template v-if="selectedAnswer != ''">
                <v-row>
                    <v-col>
                        <v-alert
                            :on-update:model-value="autoCorrect()"
                            :color="getAlertColor()"
                            :icon="getAlertIcon()"
                            :title="getAlertTitle()"
                            :text="selectedAlertMessage"
                        ></v-alert>
                    </v-col>
                </v-row>
                <v-row v-if="isCorrectAnswer || isAnyAnswer">
                    <v-col>
                        <v-btn 
                            v-if="isFinalQuestion"
                            @click="proceed()"
                            variant="outlined"
                            color="secondary"
                        >
                            See results
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
            selectedAlertMessage: computed(() => this.question.options.find(o => o.value === this.selectedAnswer).alertMessage),
            isCorrectAnswer: computed(() => this.selectedAnswer === this.question.correctAnswer),
            isAnyAnswer: computed(() => this.question.anyAnswer)
        }
    },
    methods: {
        nextQuestion() {
            this.$emit("correctAnswer");

            this.selectedAnswer = ''
        },
        proceed() {
            this.$emit("proceed")
        },
        autoCorrect() {
            if(this.question.autoCorrect && this.selectedAnswer !== this.question.correctAnswer) {
                this.selectedAnswer = this.question.correctAnswer
            }
        },
        getAlertColor(){
            return this.isCorrectAnswer 
                ? 'success'
                : this.isAnyAnswer
                    ? 'info'
                    : 'error'
        },
        getAlertIcon(){
            return this.isCorrectAnswer 
                ? '$success'
                : this.isAnyAnswer
                    ? '$info'
                    : '$error'
        },
        getAlertTitle() {
            return this.isCorrectAnswer 
                ? 'Correct!'
                : this.isAnyAnswer
                    ? ''
                    : 'Wrong answer!'
        }
    }
}
</script>