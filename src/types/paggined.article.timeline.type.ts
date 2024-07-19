import ArticleTimelineType from "./article.timeline.type";

interface PaginatedArticleTimelineType {
  results: ArticleTimelineType[];
  total: number;
}

export default PaginatedArticleTimelineType;
