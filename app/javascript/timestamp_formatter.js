document.addEventListener("DOMContentLoaded", function () {
  const formatTimestamps = () => {
    document.querySelectorAll(".timestamp").forEach((element) => {
    const utcTimestamp = element.getAttribute("data-utc");
    if (utcTimestamp) {
        const localDate = new Date(utcTimestamp);
        const formattedDate = localDate.toLocaleString("en-GB", {
          day: "2-digit",
          month: "short",
          year: "numeric",
          hour: "2-digit",
          minute: "2-digit",
          hour12: true,
        });
        element.textContent = formattedDate;
    }
    });
  };

  formatTimestamps();
});
