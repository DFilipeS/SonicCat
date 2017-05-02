import MainView from './main';

export default class View extends MainView {
  mount() {
    super.mount();

    // Specific logic here
    console.log('PageIndexView mounted');

    // $.post('/api/podcast', {url: 'http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao'}, function (data) {
    //   console.log('data', data);
    // });

    require('./podcast');
  }

  unmount() {
    super.unmount();

    // Specific logic here
    console.log('PageIndexView unmounted');
  }
}
