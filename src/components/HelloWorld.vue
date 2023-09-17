<template>
  <v-container class="fill-height">
    <v-responsive class="fill-height">
      <!-- <div class="text-body-2 font-weight-light mb-n1">Welcome to</div>

      <h1 class="text-h2 font-weight-bold">Vuetify</h1>

      <div class="py-14" /> -->
      
      <template v-if="state === 'start'">
        Hello and welcome!
        <v-btn @click="state = 'questions'">
          Begin
        </v-btn>
      </template>
      <template v-else-if="state==='questions'">
        <v-row class="d-flex">
          <v-col cols="auto" v-model="currentQuestionId">
            <Question v-if="currentQuestionId" v-bind:question="getQuestionById(currentQuestionId)" v-bind:isFinalQuestion="isFinalQuestion" v-on:correctAnswer="nextQuestion()" v-on:proceed="state = 'results'" />
          </v-col>
        </v-row>
      </template>
      <template v-else-if="state==='results'">
        <div>Gratz!</div>
        <v-btn 
          @click="state = 'reward'"
          variant="outlined"
          color="secondary"
        >
          Claim reward
        </v-btn>
      </template>
      <template v-else>
        <v-img
          src="@/assets/avada_kedavra.png"
        ></v-img>
      </template>
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
      }
    }
  }
</script>
