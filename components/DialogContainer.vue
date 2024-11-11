<template>
  <div
    v-motion
    :initial="{ opacity: 0, scale: 0.95, y: 20 }"
    :enter="{
      opacity: 1,
      scale: 1,
      y: 0,
      transition: {
        type: 'spring',
        stiffness: 300,
        damping: 20,
        delay: 150
      }
    }"
    :leave="{
      opacity: 0,
      scale: 0.95,
      y: 20,
      transition: {
        duration: 0.2
      }
    }"
    class="bg-white rounded-lg p-6 relative z-10 max-w-sm mx-4"
  >
    <slot />
  </div>
</template>