<template>
  <v-container class="fill-height">
    <v-responsive class="fill-height">
      <!-- <div class="text-body-2 font-weight-light mb-n1">Welcome to</div>

      <h1 class="text-h2 font-weight-bold">Vuetify</h1>

      <div class="py-14" /> -->
      
      <template v-if="state==='questions'">
        <v-row class="d-flex">
          <v-col cols="auto" v-model="currentQuestionId" v-if="currentQuestionId === 1">
            <Question v-if="currentQuestionId" v-bind:question="getQuestionById(currentQuestionId)" v-bind:isFinalQuestion="isFinalQuestion" v-on:correctAnswer="nextQuestion()" v-on:proceed="state = 'congratz'" />
          </v-col>
          <v-col cols="auto" v-model="currentQuestionId" v-if="currentQuestionId === 2">
            <Question v-if="currentQuestionId" v-bind:question="getQuestionById(currentQuestionId)" v-bind:isFinalQuestion="isFinalQuestion" v-on:correctAnswer="nextQuestion()" v-on:proceed="state = 'congratz'"/>
          </v-col>
          <v-col cols="auto" v-model="currentQuestionId" v-if="currentQuestionId === 3">
            <Question v-if="currentQuestionId" v-bind:question="getQuestionById(currentQuestionId)" v-bind:isFinalQuestion="isFinalQuestion" v-on:correctAnswer="nextQuestion()" v-on:proceed="state = 'congratz'"/>
          </v-col>
        </v-row>
      </template>
      <template v-else-if="state==='congratz'">
        <div>Gratz!</div>
        <v-btn @click="state = 'results'">
          See results
        </v-btn>
      </template>
      <template v-else>
        <div>AvadaKedavra!</div>
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
        state: "questions", // congratz, results
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
                alertMessage: "Seriously? It's not even remotely believable"
              },
              {
                value: 2,
                label: "SEB",
                alertMessage: "Good job! I knew you would get this one right."
              },
              {
                value: 3,
                label: "Doclogix",
                alertMessage: "Yeah right. Guess again!"
              },
              {
                value: 4,
                label: "Wherever the fuck I currently work",
                alertMessage: "You might want to reconsider. For your own sake!"
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
                alertMessage: "After everything you've been through, that's your choice? I think not!"
              },
              {
                value: 2,
                label: "Justas",
                alertMessage: "Fact-check: false!"
              },
              {
                value: 3,
                label: "Kasparas",
                alertMessage: "That was clearly a miss-click. I will give you another chance!"
              },
              {
                value: 4,
                label: "Pavel",
                alertMessage: "Obviously, duh!"
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
                label: "Not terrible at all, but time will tell for sure",
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
                label: "I've made a terrible mistake, I understand it now, and regret my decision entirely.",
                alertMessage: "Admitting one's mistakes is never late and simple enough. Forgiveness and redemption, on the other hand, will be much harder to acquire. Better to start sooner than later."
              }
            ],
            correctAnswer: 4
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
          console.log("Current question id: " + this.currentQuestionId)
        }
        else {
          console.log("see results?")
        }
      }
    }
  }
</script>