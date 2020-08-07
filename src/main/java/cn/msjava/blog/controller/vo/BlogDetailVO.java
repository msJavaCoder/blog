package cn.msjava.blog.controller.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class BlogDetailVO implements Serializable {
    private Long blogId;

    //文章标题
    private String blogTitle;
    //文章分类id
    private Integer blogCategoryId;

    private Integer commentCount;

    private String blogCategoryIcon;
    //文章分类名称
    private String blogCategoryName;

    private String blogCoverImage;

    private Long blogViews;

    private List<String> blogTags;

    private String blogContent;

    private Byte enableComment;

    private Date createTime;

}
