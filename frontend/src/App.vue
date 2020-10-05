<template>
  <div class="app background">
    <v-app id="inspire">
      <v-main>
        <v-container class="fill-height parent-container" fluid>
          <transition name="fade" mode="out-in">
            <router-view></router-view>
          </transition>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script>

export default {
  name: 'App'
}
</script>

<style>
  .fade-enter-active,
  .fade-leave-active {
    transition-duration: 0.2s;
    transition-property: opacity;
    transition-timing-function: ease;
  }

  .fade-enter,
  .fade-leave-active {
    opacity: 0
  }
  .background {
    background-image: url(./assets/background-image.jpeg);
    background-size: cover;
  }
  #inspire {
    background: none;
  }
</style>
