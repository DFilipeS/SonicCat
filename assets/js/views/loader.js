import MainView    from './main';
import PageIndexView from './index';
import FeedShowView from './feed/loader';

// Collection of specific view modules
const views = {
  PageIndexView,
  FeedShowView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
