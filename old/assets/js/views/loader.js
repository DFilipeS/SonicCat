import MainView    from './main';
import PageIndexView from './index';
import FeedShowView from './feed/loader';
import FeedNewView from './FeedNewView/loader';

// Collection of specific view modules
const views = {
  PageIndexView,
  FeedShowView,
  FeedNewView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
