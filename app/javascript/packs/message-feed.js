document.addEventListener('turbo:load', () => {
  const messagesMainArea = document.querySelector('.message-detail__main');
  if (messagesMainArea) {
    messagesMainArea.scrollTop = messagesMainArea.scrollHeight;
  }
});