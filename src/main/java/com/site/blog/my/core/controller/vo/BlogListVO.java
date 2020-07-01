package com.site.blog.my.core.controller.vo;

import lombok.Data;

import java.io.Serializable;
@Data
public class BlogListVO implements Serializable {

    private Long blogId;

    private String blogTitle;

    private String blogCoverImage;

    private Integer blogCategoryId;

    private String blogCategoryIcon;

    private String blogCategoryName;

}
