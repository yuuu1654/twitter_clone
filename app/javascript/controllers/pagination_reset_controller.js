// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   connect() {
//     console.log("Pagination reset controller connected");
//   }

//   resetPagination(event) {
//     event.preventDefault();
//     let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
//     if (this.element.classList.contains('nav-tab__recommended')) {
//       newUrl += '?page=1&tab=recommended';
//     } else if (this.element.classList.contains('nav-tab__following')) {
//       newUrl += '?page=1&tab=following';
//     }
//     window.location.href = newUrl;
//   }
// }

