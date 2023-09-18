<template>
  <v-container class="fill-height">
    <v-responsive class="fill-height">
      <v-row>
        <v-col xs="12">
          <template v-if="state === 'start'">
            <v-row>
              <v-col cols="auto">
                <h1 class="text-h3 font-weight-bold">The Final Retro</h1>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="auto">
                <div class="text-body-2">
                  Hello, and welcome to the <b>Final Retro</b> session you will ever need!
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="auto">
                <div class="text-body-2">
                  My name is <span class="font-weight-black">{{ guid }}</span>. I will be your GUID on this journey!
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="auto">
                <div class="text-body-2">Click button below to begin!</div>
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
                      Calculating personality traits... Please wait..
                    </div>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="auto">
                    <div class="text-caption">
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
                          Test result
                        </v-card-title>
                        <v-card-text class="text-h6 font-weight-medium">
                          You are a <span class="font-weight-black">Terrible Person</span>
                        </v-card-text>
                        <v-card-text>
                          Oh, and did I mention? It's not a Retro session after all! <b>SPOILER ALERT</b>, I guess...
                        </v-card-text>
                        <v-card-text>
                          But honesly, what did you expect? Your shameless betrayal has led you right where you are right now, and that's entirely your fault. Yet... You have exceeded all expectations by answering most of the questions correctly.
                        </v-card-text>
                        <v-card-text>
                          Your reward, therefore, will be a path to forgiveness and redemption, even though deep down you know you don't deserve it. You should consider yourself lucky - not everyone gains such privilege after putting so little effort.
                        </v-card-text>
                        <v-card-text>
                          Press the button below to claim the reward you deserve
                        </v-card-text>
                        <v-card-actions>
                          <v-btn
                            @click="isRevealed = true; state = 'reward'"
                            variant="outlined"
                            color="primary"
                          >
                            Get Rewarded
                          </v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-col>
                  </v-row>
                </v-container>
              </v-col>
            </v-row>
          </template>
          <template v-else>
            <v-card variant="outlined">
              <v-card-actions>
                <v-img
                  src="@/assets/avada_kedavra.png"
                  cover
                ></v-img>
              </v-card-actions>
              <v-card-text class="text-caption font-italic">
                Your evaluation report will be delivered to your supervisor immediately. An action will be taken for or against you, based on the results.
              </v-card-text>
              <v-card-text class="font-weight-medium font-italic">
                Thank you for taking part in this experimental test! Good luck!
              </v-card-text>
            </v-card>
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
        state: "start",
        currentQuestionId: 1,
        questionsCount: computed(() => this.questions.length),
        isFinalQuestion: computed(() => this.currentQuestionId === this.questionsCount),
        guid: computed(() => ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
          (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
        )),
        questions: [
          {
            id: 1,
            question: "What is your favorite workplace?",
            options: [
              {
                value: 1,
                label: "Danske",
                alertMessage: "There is no need to lie. Everybody knows this is not it"
              },
              {
                value: 2,
                label: "SEB",
                alertMessage: "Oh, you got something right, what a remarkable surprise"
              },
              {
                value: 3,
                label: "Doclogix",
                alertMessage: "Ha-ha.. Would be funny if it wasn't sad"
              },
              {
                value: 4,
                label: "My current horrible workplace",
                alertMessage: "You are simply.. Wrong"
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
                alertMessage: "Ah yes, that explains very well, why your pull requests took forever to get approved, right? Wrong!"
              },
              {
                value: 2,
                label: "Jonas",
                alertMessage: "If you don't believe this yourself, how can anybody else?"
              },
              {
                value: 3,
                label: "Kasparas",
                alertMessage: "That was clearly a miss-click. You should correct this before it's too late"
              },
              {
                value: 4,
                label: "Pavel",
                alertMessage: "It is almost adorable how much you favor this one person over everyone else. You should know better than picking favorites at a workplace. It is toxic behavior"
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
                label: "I've made a terrible mistake, I am very miserable and regret my decision entirely.",
                alertMessage: "See, wasn't that hard. There is no shame in admitting your own mistakes, even the most terrible ones. Forgiveness and redemption, on the other hand, will be much more difficult to acquire."
              }
            ],
            correctAnswer: 4
          },
          {
            id: 4,
            question: "What do you value the most in your colleagues?",
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
                alertMessage: "That is truly the most genuine form of social engagement, regardless of what company policies say"
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
                alertMessage: "Most unusual, yet not surprising at all, considering your overall history, not just recent events"
              },
              {
                value: 2,
                label: "I am selfish and greedy. I did this for the money",
                alertMessage: "If it wasn't so overwhelmingly typical, I would say you are lying to me"
              },
              {
                value: 3,
                label: "I feared for my own life and had to run away",
                alertMessage: "Aren't we all? What was even the point? If you wanted to outrun the inevitable, you should have found shelter in a company that deals with spaceships, not planes"
              },
              {
                value: 4,
                label: "I did it for fun",
                alertMessage: "I'm sure the paperwork was fun. But not as fun as the next 3 months fighting for survival. What? You didn't think this through? Oh well, there is no way back now"
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