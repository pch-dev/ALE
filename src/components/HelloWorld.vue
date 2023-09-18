<template>
  <v-container class="fill-height">
    <v-responsive class="fill-height">
      <v-row>
        <v-col xs="12">
          <template v-if="state === 'start'">
            <v-row>
              <v-col cols="auto">
                <h1 class="text-h3 font-weight-bold">The Ultimate Personality Test</h1>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="auto">
                <div class="text-body-2 font-weight-light mb-n1">Take this test and you will learn everything you will ever need to know about yourself!</div>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="auto">
                <v-btn 
                  @click="state = 'questions'"
                  variant="outlined"
                  color="primary"
                >
                  Begin
                </v-btn>
              </v-col>
            </v-row>
          </template>
          <template v-else-if="state==='questions'">
            <v-row class="d-flex">
              <v-col cols="auto" v-model="currentQuestionId">
                <Question 
                  v-if="currentQuestionId" 
                  v-bind:question="getQuestionById(currentQuestionId)" 
                  v-bind:isFinalQuestion="isFinalQuestion" 
                  v-on:correctAnswer="nextQuestion()" 
                  v-on:proceed="state = 'results'; load()" 
                />
              </v-col>
            </v-row>
          </template>
          <template v-else-if="state==='results'">
            <v-row>
              <v-col cols="auto" v-if="isLoading">
                <v-row>
                  <v-col cols="auto">
                    <v-progress-circular
                      indeterminate
                      color="primary"
                    ></v-progress-circular>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="auto">
                    <div>
                      Calculating test results...
                    </div>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="auto">
                    <div>
                      Calculation algorithms are empowered by a powerful AI which was designed to empower calculation algorithms by a powerful AI
                    </div>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="auto" v-else>
                <v-container fluid>
                  <v-row>
                    <v-col cols="auto">
                      <v-card variant="outlined">
                        <v-card-title class="text-h4">
                          Test Result
                        </v-card-title>
                        <v-card-text class="text-h6 font-weight-medium">
                          You are a <span class="font-weight-black">terrible person</span>
                        </v-card-text>
                        <v-card-text>
                          Honesly, what did you expect? Your shameless betrayal has led you right where you are right now, and that's entirely your fault. And yet, you have exceeded expectations by answering most of the questions correctly. For that, and that alone, you will be rewarded accordingly.
                        </v-card-text>
                        <v-card-text>
                          Your reward - a clear path to forgiveness and redemption, even though deep down you know you don't deserve it. Yet you should consider yourself lucky, as not everyone gains such privilege with so little effort.
                        </v-card-text>
                        <v-card-text>
                          Press the button below to claim your reward.
                        </v-card-text>
                        <v-card-actions>
                          <v-btn
                            @click="isRevealed = true"
                            variant="outlined"
                            color="primary"
                          >
                            Reveal
                          </v-btn>
                        </v-card-actions>
                        <template v-if="isRevealed">
                          <v-card-actions>
                            <v-img
                              src="@/assets/avada_kedavra.png"
                              cover
                            ></v-img>
                          </v-card-actions>
                          <v-card-text>
                            Your evaluation report will be delivered to your supervisor immediately. An action will be taken for or against you, based on the results.
                          </v-card-text>
                          <v-card-text>
                            Thank you for taking part in this experimental personality test! Good luck!
                          </v-card-text>
                        </template>
                      </v-card>
                    </v-col>
                  </v-row>
                </v-container>
              </v-col>
            </v-row>
          </template>
          <template v-else>
            <v-img
              src="@/assets/avada_kedavra.png"
            ></v-img>
          </template>
        </v-col>
      </v-row>
    </v-responsive>
  </v-container>
</template>

<script setup>
  import Question from '@/components/Question.vue'
  import { computed } from 'vue'
</script>

<script>
  export default {
    data () {
      return {
        isRevealed: false,
        isLoading: false,
        state: "start", // questions, results, reward
        currentQuestionId: 1,
        questionsCount: computed(() => this.questions.length),
        isFinalQuestion: computed(() => this.currentQuestionId === this.questionsCount),
        questions: [
          {
            id: 1,
            question: "What is your favorite workplace?",
            options: [
              {
                value: 1,
                label: "Danske",
                alertMessage: "It's not even remotely believable. Why don't you give it another shot?"
              },
              {
                value: 2,
                label: "SEB",
                alertMessage: "Good job! I knew you would get this one right."
              },
              {
                value: 3,
                label: "Doclogix",
                alertMessage: "Ha-ha-ha. Would be funny, if it wasn't sad."
              },
              {
                value: 4,
                label: "Wherever the f*** I currently work",
                alertMessage: "Now that can't be right, right? You might want to reconsider."
              }
            ],
            correctAnswer: 2
          },
          {
            id: 2,
            question: "Who is your favorite colleague?",
            options: [
              {
                value: 1,
                label: "Maksim",
                alertMessage: "After everything you've been through, that's your choice?"
              },
              {
                value: 2,
                label: "Jonas",
                alertMessage: "If you don't believe this yourself, how can anybody else?"
              },
              {
                value: 3,
                label: "Kasparas",
                alertMessage: "That was clearly a miss-click. You should correct this before it's too late."
              },
              {
                value: 4,
                label: "Pavel",
                alertMessage: "It is almost adorable how much you favor this one person over everyone else."
              }
            ],
            correctAnswer: 4
          },
          {
            id: 3,
            question: "How do you feel about your new job?",
            options: [
              {
                value: 1,
                label: "It's amazing! I'm very happy about it",
                alertMessage: "",
                isDisabled: true
              },
              {
                value: 2,
                label: "Pretty good right now, but time will tell for sure",
                alertMessage: "",
                isDisabled: true
              },
              {
                value: 3,
                label: "The pay is good, but opportunities are quite limited",
                alertMessage: "",
                isDisabled: true
              },
              {
                value: 4,
                label: "I've made a terrible mistake, I understand it now and regret my decision entirely.",
                alertMessage: "See, wasn't that hard! There is no shame in admitting one's mistakes. Forgiveness and redemption, on the other hand, will be much more difficult to acquire. Better start it sooner than later!"
              }
            ],
            correctAnswer: 4
          },
          {
            id: 4,
            question: "What do you appreciate the most in your colleagues?",
            autoCorrect: true,
            options: [
              {
                value: 1,
                label: "Help",
                alertMessage: ""
              },
              {
                value: 2,
                label: "Team work",
                alertMessage: ""
              },
              {
                value: 3,
                label: "Harassment",
                alertMessage: "Ah.. That is truly the purest form of social engagement, regardless of what company policies say"
              },
              {
                value: 4,
                label: "Jokes",
                alertMessage: ""
              }
            ],
            correctAnswer: 3
          },
          {
            id: 5,
            question: "Why did you decide to betray your colleagues?",
            anyAnswer: true,
            options: [
              {
                value: 1,
                label: "I enjoy causing others pain",
                alertMessage: "Like the pain you caused your own laptop when you spilled wine all over it?"
              },
              {
                value: 2,
                label: "I am selfish and greedy. I did this for the money",
                alertMessage: "The overwhelming amount of \"Typical\" in this situation is nothing but depressing"
              },
              {
                value: 3,
                label: "I feared for my own life and had to run away",
                alertMessage: "Then perhaps you should have found shelter in a company that builds spaceships."
              },
              {
                value: 4,
                label: "I did it for fun",
                alertMessage: "I'm sure the paperwork was fun. I'm also sure that planes falling from the sky will be just as fun. Can't wait to read the news."
              }
            ]
          }
        ]
      }
    },
    methods: {
      getQuestionById(id) {
        return this.questions.find(q => q.id == id)
      },
      nextQuestion() {
        if(this.isFinalQuestion === false) {
          this.currentQuestionId += 1;
        }
      },
      load(){
        this.isLoading = true

        setInterval(() => {
          this.isLoading = false
        }, 10000)
      }
    }
  }
</script>
<style scoped>
.v-progress-circular {
  margin: 1rem;
}
</style>