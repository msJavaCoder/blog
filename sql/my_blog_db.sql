/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50648
 Source Host           : localhost:3306
 Source Schema         : my_blog_db

 Target Server Type    : MySQL
 Target Server Version : 50648
 File Encoding         : 65001

 Date: 01/07/2020 14:26:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_user`;
CREATE TABLE `tb_admin_user`  (
  `admin_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `login_user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员登陆名称',
  `login_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员登陆密码',
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员显示昵称',
  `locked` tinyint(4) NULL DEFAULT 0 COMMENT '是否锁定 0未锁定 1已锁定无法登陆',
  PRIMARY KEY (`admin_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_admin_user
-- ----------------------------
INSERT INTO `tb_admin_user` VALUES (3, 'msjava', '8509c5d0790541134c9a601117a41694', '码上Java', 0);

-- ----------------------------
-- Table structure for tb_blog
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`  (
  `blog_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '博客表主键id',
  `blog_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客标题',
  `blog_sub_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客自定义路径url',
  `blog_cover_image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客封面图',
  `blog_content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客内容',
  `blog_category_id` int(11) NOT NULL COMMENT '博客分类id',
  `blog_category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客分类(冗余字段)',
  `blog_tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客标签',
  `blog_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-草稿 1-发布',
  `blog_views` bigint(20) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `enable_comment` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-允许评论 1-不允许评论',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`blog_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog
-- ----------------------------
INSERT INTO `tb_blog` VALUES (1, '如何使用POI及EasyExcel操作Excel', '', 'http://localhost:8080/admin/dist/img/rand/4.jpg', '# 如何使用POI及EasyExcel操作Excel\n\n## 1. POI\n\n+ 导入依赖\n\n```xml\n            <!--03--> \n           <dependency>\n                <groupId>org.apache.poi</groupId>\n                <artifactId>poi</artifactId>\n                <version>3.9</version>\n            </dependency>\n            <!--07--> \n            <dependency>\n                <groupId>org.apache.poi</groupId>\n                <artifactId>poi-ooxml</artifactId>\n                <version>3.9</version>\n            </dependency>\n```\n\n+ 写入Excel _Demo\n\n```java\npublic class ExcelWriteTest {\n    String PATH=\"F:\\\\easyExcel\";\n    @Test\n    public void test() throws IOException {\n        long begin=System.currentTimeMillis();\n        //1.创建一个工作薄  \n        Workbook workbook=new HSSFWorkbook();  //2003 xls文件    优点：运行效率高，缺点：存储记录不多63359条\n        //Workbook workbook=new XSSFWorkbook();//2007 xlsX文件  可以存储更多记录，缺点就是比03慢、消耗内存，也会发生溢出，比如100万条  升级版可以使用 Workbook workbook=new SXSSFWorkbook();   xlsX文件  \n        //2.创建一个工作表\n        Sheet sheet=workbook.createSheet();\n        for (int rowNum = 0; rowNum < 65536; rowNum++) {\n            //3.创建行\n            Row row = sheet.createRow(rowNum);\n            for (int cellNum = 0; cellNum <10 ; cellNum++) {\n                //4.创建列\n                Cell cell = row.createCell(cellNum);\n                cell.setCellValue(cellNum);\n            }\n        }\n        System.out.println(\"生成完成\");\n        FileOutputStream fileOutputStream = new FileOutputStream(PATH + \"xxx.xls\");\n        workbook.write(fileOutputStream);\n        //关闭流\n        fileOutputStream.close();\n        //清楚临时文件\n        ((SXSSFWorkbook) workbook).dispose();\n        long end=System.currentTimeMillis();\n        //运行时间\n        System.out.println((double) (end-begin)/1000);\n    }\n}\n```', 2, 'Java基础', 'Java', 1, 5, 0, 0, '2020-06-30 18:44:20', '2020-06-30 18:44:20');
INSERT INTO `tb_blog` VALUES (2, 'HashMap 为什么是线程不安全的？', '', 'http://localhost:8080/admin/dist/img/rand/25.jpg', '## 1. 同时 put 碰撞导致数据丢失\n\n比如，有多个线程同时使用 put 来添加元素，而且恰好两个 put 的 key 是一样的，它们发生了碰撞，也就是根据 hash 值计算出来的 bucket 位置一样，并且两个线程又同时判断该位置是空的，可以写入，所以这两个线程的两个不同的 value 便会添加到数组的同一个位置，这样最终就只会保留一个数据，丢失一个数据。\n\nJDK1.8源码分析：\n\n```java\n public V put(K key, V value) {\n        //调用putVal\n        return putVal(hash(key), key, value, false, true);\n    }\n   \n    final V putVal(int hash, K key, V value, boolean onlyIfAbsent,\n                   boolean evict) {\n        Node<K,V>[] tab; Node<K,V> p; int n, i;\n        if ((tab = table) == null || (n = tab.length) == 0)\n            n = (tab = resize()).length;\n        if ((p = tab[i = (n - 1) & hash]) == null)\n            tab[i] = newNode(hash, key, value, null);\n        else {\n            Node<K,V> e; K k;\n            if (p.hash == hash &&\n                ((k = p.key) == key || (key != null && key.equals(k))))\n                e = p;\n            else if (p instanceof TreeNode)\n                e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);\n            else {\n                for (int binCount = 0; ; ++binCount) {\n                    if ((e = p.next) == null) {\n                        p.next = newNode(hash, key, value, null);\n                        if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st\n                            treeifyBin(tab, hash);\n                        break;\n                    }\n                    if (e.hash == hash &&\n                        ((k = e.key) == key || (key != null && key.equals(k))))\n                        break;\n                    p = e;\n                }\n            }\n            if (e != null) { // existing mapping for key\n                V oldValue = e.value;\n                if (!onlyIfAbsent || oldValue == null)\n                    e.value = value;\n                afterNodeAccess(e);\n                return oldValue;\n            }\n        }\n        //线程不安全所在，++操作并不是原子操作\n        /**\n        *    第一个步骤是读取；\n        *    第二个步骤是增加；\n        *    第三个步骤是保存。 \n        */\n        ++modCount;\n        if (++size > threshold)\n            resize();\n        afterNodeInsertion(evict);\n        return null;\n    }\n```\n\n![img](https://s0.lgstatic.com/i/image3/M01/60/C7/Cgq2xl4YRJeAC6fuAAA8JO4TxM0077.png)\n\n我们根据箭头指向依次看，假设线程 1 首先拿到 i=1 的结果，然后进行 i+1 操作，但此时 i+1 的结果并没有保存下来，线程 1 就被切换走了，于是 CPU 开始执行线程 2，它所做的事情和线程 1 是一样的 i++ 操作，但此时我们想一下，它拿到的 i 是多少？实际上和线程 1 拿到的 i 的结果一样都是 1，为什么呢？因为线程 1 虽然对 i 进行了 +1 操作，但结果没有保存，所以线程 2 看不到修改后的结果。\n\n然后假设等线程 2 对 i 进行 +1 操作后，又切换到线程 1，让线程 1 完成未完成的操作，即将 i + 1 的结果 2 保存下来，然后又切换到线程 2 完成 i = 2 的保存操作，虽然两个线程都执行了对 i 进行 +1 的操作，但结果却最终保存了 i = 2 的结果，而不是我们期望的 i = 3，这样就发生了线程安全问题，导致了数据结果错误，这也是最典型的线程安全问题。\n\n## 2.可见性问题无法保证\n\n可见性也是线程安全的一部分，如果某一个数据结构声称自己是线程安全的，那么它同样需要保证可见性，也就是说，当一个线程操作这个容器的时候，该操作需要对另外的线程都可见，也就是其他线程都能感知到本次操作。可是 HashMap 对此是做不到的，如果线程 1 给某个 key 放入了一个新值，那么线程 2 在获取对应的 key 的值的时候，它的可见性是无法保证的，也就是说线程 2 可能可以看到这一次的更改，但也有可能看不到。所以从可见性的角度出发，HashMap 同样是线程非安全的。\n\n## 3.死循环造成 CPU 100%\n\nHashMap 有可能会发生死循环并且造成  CPU 100% ，这种情况发生最主要的原因就是在扩容的时候，也就是内部新建新的 HashMap 的时候，扩容的逻辑会反转散列桶中的节点顺序，当有多个线程同时进行扩容的时候，由于 HashMap 并非线程安全的，所以如果两个线程同时反转的话，便可能形成一个循环，并且这种循环是链表的循环，相当于 A 节点指向 B 节点，B 节点又指回到 A 节点，这样一来，在下一次想要获取该 key 所对应的 value 的时候，便会在遍历链表的时候发生永远无法遍历结束的情况，也就发生 CPU 100% 的情况。\n\n## 4. 扩容期间取出的值不准确\n\nHashMap 本身默认的容量不是很大，如果不停地往 map 中添加新的数据，它便会在合适的时机进行扩容。而在扩容期间，它会新建一个新的空数组，并且用旧的项填充到这个新的数组中去。那么，在这个填充的过程中，如果有线程获取值，很可能会取到 null 值，而不是我们所希望的、原来添加的值。', 2, 'Java基础', 'HashMap,Java', 1, 4, 0, 0, '2020-06-30 22:28:39', '2020-06-30 22:28:39');
INSERT INTO `tb_blog` VALUES (3, 'asfasfasf', '', 'http://localhost:8080/admin/dist/img/rand/27.jpg', 'asfasfa', 2, 'Java基础', 'asfasf', 1, 0, 0, 1, '2020-07-01 13:59:53', '2020-07-01 13:59:53');

-- ----------------------------
-- Table structure for tb_blog_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_category`;
CREATE TABLE `tb_blog_category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类表主键',
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类的名称',
  `category_icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类的图标',
  `category_rank` int(11) NOT NULL DEFAULT 1 COMMENT '分类的排序值 被使用的越多数值越大',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog_category
-- ----------------------------
INSERT INTO `tb_blog_category` VALUES (1, 'Java基础', '/admin/dist/img/category/15.png', 1, 1, '2020-06-30 17:54:00');
INSERT INTO `tb_blog_category` VALUES (2, 'Java基础', '/admin/dist/img/category/15.png', 5, 0, '2020-06-30 18:43:05');
INSERT INTO `tb_blog_category` VALUES (3, 'Spring', '/admin/dist/img/category/6.png', 1, 1, '2020-06-30 21:11:09');
INSERT INTO `tb_blog_category` VALUES (4, 'Spring', '/admin/dist/img/category/09.png', 1, 0, '2020-07-01 09:47:24');

-- ----------------------------
-- Table structure for tb_blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_comment`;
CREATE TABLE `tb_blog_comment`  (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `blog_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '关联的blog主键',
  `commentator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论者名称',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论人的邮箱',
  `website_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '网址',
  `comment_body` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `comment_create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '评论提交时间',
  `commentator_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论时的ip地址',
  `reply_body` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回复内容',
  `reply_create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '回复时间',
  `comment_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否审核通过 0-未审核 1-审核通过',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog_comment
-- ----------------------------
INSERT INTO `tb_blog_comment` VALUES (1, 1, 'asdasd', '2992648437@qq.com', '', 'asfasfasf', '2020-06-30 22:26:39', '', '', '2020-06-30 22:26:39', 1, 1);
INSERT INTO `tb_blog_comment` VALUES (2, 2, '怎么称呼', '2125635467@qq.com', '', '不错', '2020-07-01 14:04:34', '', '', '2020-07-01 14:04:34', 1, 0);

-- ----------------------------
-- Table structure for tb_blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_tag`;
CREATE TABLE `tb_blog_tag`  (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签表主键id',
  `tag_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名称',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog_tag
-- ----------------------------
INSERT INTO `tb_blog_tag` VALUES (1, 'Java', 0, '2020-06-30 18:17:56');
INSERT INTO `tb_blog_tag` VALUES (2, 'MySQL', 0, '2020-06-30 18:18:09');
INSERT INTO `tb_blog_tag` VALUES (3, 'SpringBoot', 0, '2020-06-30 18:22:37');
INSERT INTO `tb_blog_tag` VALUES (4, 'Spring', 0, '2020-06-30 18:22:44');
INSERT INTO `tb_blog_tag` VALUES (5, 'SpringMVC', 0, '2020-06-30 18:24:23');
INSERT INTO `tb_blog_tag` VALUES (6, '计算机基础', 0, '2020-06-30 18:24:32');
INSERT INTO `tb_blog_tag` VALUES (7, 'Redis', 0, '2020-06-30 18:24:38');
INSERT INTO `tb_blog_tag` VALUES (8, 'MyBatis', 0, '2020-06-30 18:24:45');
INSERT INTO `tb_blog_tag` VALUES (9, 'JavaScript', 0, '2020-06-30 18:24:56');
INSERT INTO `tb_blog_tag` VALUES (10, 'Linux', 0, '2020-06-30 20:41:10');
INSERT INTO `tb_blog_tag` VALUES (11, 'HashMap', 0, '2020-06-30 22:28:39');
INSERT INTO `tb_blog_tag` VALUES (12, 'asfasf', 0, '2020-07-01 13:59:53');

-- ----------------------------
-- Table structure for tb_blog_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_tag_relation`;
CREATE TABLE `tb_blog_tag_relation`  (
  `relation_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系表id',
  `blog_id` bigint(20) NOT NULL COMMENT '博客id',
  `tag_id` int(11) NOT NULL COMMENT '标签id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`relation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog_tag_relation
-- ----------------------------
INSERT INTO `tb_blog_tag_relation` VALUES (2, 2, 1, '2020-06-30 22:28:39');
INSERT INTO `tb_blog_tag_relation` VALUES (3, 2, 11, '2020-06-30 22:28:39');
INSERT INTO `tb_blog_tag_relation` VALUES (4, 1, 1, '2020-06-30 22:37:01');
INSERT INTO `tb_blog_tag_relation` VALUES (5, 3, 12, '2020-07-01 13:59:53');

-- ----------------------------
-- Table structure for tb_link
-- ----------------------------
DROP TABLE IF EXISTS `tb_link`;
CREATE TABLE `tb_link`  (
  `link_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '友链表主键id',
  `link_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '友链类别 0-友链 1-推荐 2-个人网站',
  `link_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站名称',
  `link_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站链接',
  `link_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站描述',
  `link_rank` int(11) NOT NULL DEFAULT 0 COMMENT '用于列表排序',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`link_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_link
-- ----------------------------
INSERT INTO `tb_link` VALUES (1, 2, 'msJava', 'https://github.com/msJavaCoder', '微信公众号', 0, 0, '2020-06-30 19:24:41');

SET FOREIGN_KEY_CHECKS = 1;
