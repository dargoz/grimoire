{{flutter_js}}
{{flutter_build_config}}

var loadingDesc = document.querySelector('#loading-desc');
var loadingPercent = document.querySelector('#loading-percent');
var loadingBar = document.querySelector('#loading-bar');
loadingDesc.textContent = "Loading Grimoire...";
loadingPercent.textContent = "30%";
loadingBar.style.width = 30 + "%";
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    loadingPercent.textContent = "60%";
    loadingBar.style.width = 60 + "%";
    const appRunner = await engineInitializer.initializeEngine();
    loadingPercent.textContent = "100%";
    loadingBar.style.width = 100 + "%";
    await appRunner.runApp();
  }
});