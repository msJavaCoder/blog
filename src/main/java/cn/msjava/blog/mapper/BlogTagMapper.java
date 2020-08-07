package cn.msjava.blog.mapper;

import cn.msjava.blog.entity.BlogTag;
import cn.msjava.blog.entity.BlogTagCount;
import cn.msjava.blog.util.PageQueryUtil;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface BlogTagMapper {
    int deleteByPrimaryKey(Integer tagId);

    int insert(BlogTag record);

    int insertSelective(BlogTag record);

    BlogTag selectByPrimaryKey(Integer tagId);

    BlogTag selectByTagName(String tagName);

    int updateByPrimaryKeySelective(BlogTag record);

    int updateByPrimaryKey(BlogTag record);

    List<BlogTag> findTagList(PageQueryUtil pageUtil);

    int getTotalTags(PageQueryUtil pageUtil);

    int deleteBatch(Integer[] ids);

    int batchInsertBlogTag(List<BlogTag> tagList);

    List<BlogTagCount> getTagCount();
}