[TOC]





# HTTP

"http://"->使用的是HTTP协议进行通信

protocol 是一种standard一种paradigm，everyone obey the rule.

通信双方用统一的规范



机器之间通信，要让machine 完整 准确 collect info，所以规定了protocol

机器通信时候，要以“”的格式来传输信息。







# URL

URL（Uniform Resource Locator）即“统一资源定位符”。Literally，“统一”的意思就是全世界互联网上只要能被访问到的资源都有这么一个长得大同小异的符号标识。“资源”嘛，就更好理解了，只要是可以独立存在的集合都可以被称作是资源，什么文本、图片、音乐、视频，都算。“定位”，给你一个“四川省成都市青羊区青华路 37 号”的地址，你能比划着找着杜甫草堂。给你一个URL，你一样能找到资源。无论访问互联网上anything，只要给你这么一个对应的 URL，你都能把他给找出来。

URI（Uniform Resource Identifier，统一资源标识符）的概念。URL 是 URI 的真子集；也就是说一个 URL 一定是 URI，但一个 URI 不一定是 URL。在浏览器访问网页的时候，多数常见的情况下我们看到的 URI 都是 URL。

* 如果某个 URL 指定的文件就在与客户端直接通信的主机上，那么只需使用文件在该主机上的绝对路径即可区别这个文件；此时的 URI 就可以是这个绝对路径，比对应的 URL 更加简短。
* 但如果与客户端直接通信的主机仅仅是一个代理（简单理解为中转），此时只使用绝对路径是不够的，还需要指明是哪台主机，这样代理才能够找到这台主机进而找到这个文件；这种情况下，URI 和 URL 就是相等的了。



E.g.http://www.justdopython.com/2019/04/04/writing-specifications/   这么一个文件夹

![img](https://pic3.zhimg.com/80/v2-5c9432498cf727b000fc053bdaf8c16a_720w.webp)

第一部分的“http”表明使用的是 HTTP 协议进行通信。第三部分“www.justdopython.com”称为“域名”，可以简单地理解为互联网上的某一台主机（实际情况要更复杂），也就是一个跟你手头的电脑差不多的玩意儿。第四部分“/2019/04/04/writing-specifications/”就是请求的资源在这台主机上的路径了，可以看出其路径结构是 */ -> 2019/ -> 04/ -> 04/ -> writing-specifications/*，这一点容易理解，最后一级目录（Windows 文件夹）就是 writing-specifications。

就定位了一个文件夹，那这网页显示的是个啥呀？文件夹不带这个功能啊？根据各个 web 服务器设置的不同，它们可以指定某些文件作为不指定具体资源时的默认对象，一般是“index.html”。实际上你可以试一试，在这个 URL 的后面加上“index.html”，即访问：[http://www.justdopython.com/2019/04/04/writing-specifications/index.html](https://link.zhihu.com/?target=http%3A//www.justdopython.com/2019/04/04/writing-specifications/index.html)，可以得到相同的结果



# HTTP protocol格式

协议分为两个大类，请求、响应

## HTTP请求

一般地，HTTP 协议格式主要分成四个部分：**起始行**、**消息头**、**空行**、**消息体**；如图所示。

request line; requet header;

**![img](https://pic1.zhimg.com/80/v2-1f7e7873aa7471e599c766abb3c24844_720w.webp)**



<img src="https://www.runoob.com/wp-content/uploads/2013/11/2012072810301161.png" alt="img" style="zoom:150%;" />





其中，**起始行**又包含三个信息：**方法**、**URI**、**HTTP 协议版本**。

“方法”指的是本次请求要执行的操作，有时也称“HTTP 谓词”或“HTTP 动词”。常见的方法是`GET`和`POST`这两个：`GET`表示客户端要从服务器获取资源；而`POST`则表示客户端要想服务器传输一些表单数据。

**URI** 在前面已经略作讲解，因此不再赘述。一般来说会是一个绝对路径，末尾可以跟上一个问号“?”和查询字符串；当使用代理时，就会是一个完整的 URL。

起始行最常见的形式类似于下面这样：

```text
GET /just/do/python/logo.png HTTP/1.1
```

当使用代理时则会变成（该 URL 为虚构）：

```text
GET http://www.justdopython.com/just/do/python/logo.png 
```

协议格式的第二部分**消息头**包含一些对消息的描述信息，格式是`<field>:<value>`。具体地，各种消息头又被分为四大类：通用头、请求头、响应头（用于响应消息）和实体头。

第三部分空行，起到的作用是提示消息头结束、消息体开始，不需要再花费笔墨。

第四部分消息体就是正主了，也就是一条 HTTP 消息要传输的主体。然而稍稍有些尴尬的是，对于有的方法而言并不需要传输其他信息，只需要有起始行和消息头就足够了（比如`GET`方法），**因此这个部分不仅不一定是最长的，甚至可能是空的。**



## HTTP响应

与请求消息比较类似，HTTP 响应消息也分为四个部分：**状态行**、**消息头**、**空行**、**消息体**

![img](https://pic1.zhimg.com/80/v2-8e14b5dd53d3ed07b34f6f40a6acad94_720w.webp)

除了**状态行**以外，其他三个部分和请求是一样的。

状态行也由三个部分组成：**HTTP 协议版本**、**状态码**、**状态文本**。

**状态码**其实我们很熟悉。最典型的一个就是每当我们访问的某个 URL 不存在时，就会得到一个`404`的状态码。因此状态码实际上是用来标识请求成功与否的数字。除了`404`，典型的状态码还有`200`（请求成功）、`301`（资源被永久移动）、`302`（资源被临时移动）等。

#### Response codes 

* 1xx: information
* 2xx: success (200 OK, 201 Created, …)
* 3xx: redirect (301 Moved Permanently, …)、
* 4xx: client error (400 Bad Request, 403 Forbidden, 404 Not Found, …)
* 5xx: server error (500 Internal Server Error …

因此一个典型的状态行可能长成这样：

```text
HTTP/1.1 404 Not Found
```

![img](https://www.runoob.com/wp-content/uploads/2013/11/httpmessage.jpg)

HTTP 协议中共定义了八种方法或者叫“动作”来表明对 Request-URI 指定的资源的不同操作方式，具体介绍如下：

-  **OPTIONS**：返回服务器针对特定资源所支持的HTTP请求方法。也可以利用向Web服务器发送'*'的请求来测试服务器的功能性。
-  **HEAD**：向服务器索要与GET请求相一致的响应，只不过响应体将不会被返回。这一方法可以在不必传输整个响应内容的情况下，就可以获取包含在响应消息头中的元信息。
-  **GET**：向特定的资源发出请求。
-  **POST**：向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的创建和/或已有资源的修改。
-  **PUT**：向指定资源位置上传其最新内容。
-  **DELETE**：请求服务器删除 Request-URI 所标识的资源。
-  **TRACE**：回显服务器收到的请求，主要用于测试或诊断。
-  **CONNECT**：HTTP/1.1 协议中预留给能够将连接改为管道方式的代理服务器。

虽然 HTTP 的请求方式有 8 种，但是我们在实际应用中常用的也就是 **get** 和 **post**，其他请求方式也都可以通过这两种方式间接的来实现。



# HTTP 响应头信息

HTTP 响应头信息是服务器在响应客户端的HTTP请求时发送的一系列头字段，它们提供了关于响应的附加信息和服务器的指令。

以下是一些常见的 HTTP 响应头信息：

| 响应头信息（英文）        | 响应头信息（中文） | 描述                                                         |
| :------------------------ | :----------------- | :----------------------------------------------------------- |
| Date                      | 日期               | 响应生成的日期和时间。例如：Wed, 18 Apr 2024 12:00:00 GMT    |
| Server                    | 服务器             | 服务器软件的名称和版本。例如：Apache/2.4.1 (Unix)            |
| Content-Type              | 内容类型           | 响应体的媒体类型（MIME类型），如`text/html; charset=UTF-8`, `application/json`等。 |
| Content-Length            | 内容长度           | 响应体的大小，单位是字节。例如：3145                         |
| Content-Encoding          | 内容编码           | 响应体的压缩编码，如 `gzip`, `deflate`等。                   |
| Content-Language          | 内容语言           | 响应体的语言。例如：zh-CN                                    |
| Content-Location          | 内容位置           | 响应体的 URI。例如：/index.html                              |
| Content-Range             | 内容范围           | 响应体的字节范围，用于分块传输。例如：bytes 0-999/8000       |
| Cache-Control             | 缓存控制           | 控制响应的缓存行为, 如 no-cache 表示必须重新请求。           |
| Connection                | 连接               | 管理连接的选项，如`keep-alive`或`close`，keep-alive 表示连接不会在传输后关闭。。 |
| Set-Cookie                | 设置 Cookie        | 设置客户端的 cookie。例如：sessionId=abc123; Path=/; Secure  |
| Expires                   | 过期时间           | 响应体的过期日期和时间。例如：Thu, 18 Apr 2024 12:00:00 GMT  |
| Last-Modified             | 最后修改时间       | 资源最后被修改的日期和时间。例如：Wed, 18 Apr 2024 11:00:00 GMT |
| ETag                      | 实体标签           | 资源的特定版本的标识符。例如："33a64df551425fcc55e6"         |
| Location                  | 位置               | 用于重定向的 URI。例如：/newresource                         |
| Pragma                    | 实现特定的指令     | 包含实现特定的指令，如 `no-cache`。                          |
| WWW-Authenticate          | 认证信息           | 认证信息，通常用于HTTP认证。例如：Basic realm="Access to the site" |
| Accept-Ranges             | 接受范围           | 指定可接受的请求范围类型。例如：bytes                        |
| Age                       | 经过时间           | 响应生成后经过的秒数，从原始服务器生成到代理服务器。例如：24 |
| Allow                     | 允许方法           | 列出资源允许的 HTTP 方法 。例如：GET, POST，HEAD等           |
| Vary                      | 变化               | 告诉下游代理如何使用响应头信息来确定响应是否可以从缓存中获取。例如：Accept |
| Strict-Transport-Security | 严格传输安全       | 指示浏览器仅通过 HTTPS 与服务器通信。例如：max-age=31536000; includeSubDomains |
| X-Frame-Options           | 框架选项           | 控制页面是否允许在框架中显示，防止点击劫持攻击。例如：SAMEORIGIN |
| X-Content-Type-Options    | 内容类型选项       | 指示浏览器不要尝试猜测资源的 MIME 类型。例如：nosniff        |
| X-XSS-Protection          | XSS保护            | 控制浏览器的 XSS 过滤和阻断。例如：1; mode=block             |
| Public-Key-Pins           | 公钥固定           | HTTP 头信息，用于HTTP公共密钥固定（HPKP），一种安全机制，用于防止中间人攻击。例如：pin-sha256="base64+primarykey"; pin-sha256="base64+backupkey"; max-age=expireTime |

# HTTP content-type

Content-Type（内容类型），一般是指网页中存在的 Content-Type，用于定义网络文件的类型和网页的编码，决定浏览器将以什么形式、什么编码读取这个文件，这就是经常看到一些 PHP 网页点击的结果却是下载一个文件或一张图片的原因。

Content-Type 标头告诉客户端实际返回的内容的内容类型。

语法格式：

```
Content-Type: text/html; charset=utf-8
Content-Type: multipart/form-data; boundary=something
```

实例：

![img](https://www.runoob.com/wp-content/uploads/2014/06/F7E193D6-3C08-4B97-BAF2-FF340DAA5C6E.jpg)

常见的媒体格式类型如下：

- text/html ： HTML格式
- text/plain ：纯文本格式
- text/xml ： XML格式
- image/gif ：gif图片格式
- image/jpeg ：jpg图片格式
- image/png：png图片格式

以application开头的媒体格式类型：

- application/xhtml+xml ：XHTML格式
- application/xml： XML数据格式
- application/atom+xml ：Atom XML聚合格式
- application/json： JSON数据格式
- application/pdf：pdf格式
- application/msword ： Word文档格式
- application/octet-stream ： 二进制流数据（如常见的文件下载）
- application/x-www-form-urlencoded ： <form encType=””>中默认的encType，form表单数据被编码为key/value格式发送到服务器（表单默认的提交数据的格式）

另外一种常见的媒体格式是上传文件之时使用的：

- multipart/form-data ： 需要在表单中进行文件上传时，就需要使用该格式

------

## HTTP content-type 对照表

| 文件扩展名                          | Content-Type(Mime-Type)                 | 文件扩展名 | Content-Type(Mime-Type)             |
| :---------------------------------- | :-------------------------------------- | :--------- | :---------------------------------- |
| .*（ 二进制流，不知道下载文件类型） | application/octet-stream                | .tif       | image/tiff                          |
| .001                                | application/x-001                       | .301       | application/x-301                   |
| .323                                | text/h323                               | .906       | application/x-906                   |
| .907                                | drawing/907                             | .a11       | application/x-a11                   |
| .acp                                | audio/x-mei-aac                         | .ai        | application/postscript              |
| .aif                                | audio/aiff                              | .aifc      | audio/aiff                          |
| .aiff                               | audio/aiff                              | .anv       | application/x-anv                   |
| .asa                                | text/asa                                | .asf       | video/x-ms-asf                      |
| .asp                                | text/asp                                | .asx       | video/x-ms-asf                      |
| .au                                 | audio/basic                             | .avi       | video/avi                           |
| .awf                                | application/vnd.adobe.workflow          | .biz       | text/xml                            |
| .bmp                                | application/x-bmp                       | .bot       | application/x-bot                   |
| .c4t                                | application/x-c4t                       | .c90       | application/x-c90                   |
| .cal                                | application/x-cals                      | .cat       | application/vnd.ms-pki.seccat       |
| .cdf                                | application/x-netcdf                    | .cdr       | application/x-cdr                   |
| .cel                                | application/x-cel                       | .cer       | application/x-x509-ca-cert          |
| .cg4                                | application/x-g4                        | .cgm       | application/x-cgm                   |
| .cit                                | application/x-cit                       | .class     | java/*                              |
| .cml                                | text/xml                                | .cmp       | application/x-cmp                   |
| .cmx                                | application/x-cmx                       | .cot       | application/x-cot                   |
| .crl                                | application/pkix-crl                    | .crt       | application/x-x509-ca-cert          |
| .csi                                | application/x-csi                       | .css       | text/css                            |
| .cut                                | application/x-cut                       | .dbf       | application/x-dbf                   |
| .dbm                                | application/x-dbm                       | .dbx       | application/x-dbx                   |
| .dcd                                | text/xml                                | .dcx       | application/x-dcx                   |
| .der                                | application/x-x509-ca-cert              | .dgn       | application/x-dgn                   |
| .dib                                | application/x-dib                       | .dll       | application/x-msdownload            |
| .doc                                | application/msword                      | .dot       | application/msword                  |
| .drw                                | application/x-drw                       | .dtd       | text/xml                            |
| .dwf                                | Model/vnd.dwf                           | .dwf       | application/x-dwf                   |
| .dwg                                | application/x-dwg                       | .dxb       | application/x-dxb                   |
| .dxf                                | application/x-dxf                       | .edn       | application/vnd.adobe.edn           |
| .emf                                | application/x-emf                       | .eml       | message/rfc822                      |
| .ent                                | text/xml                                | .epi       | application/x-epi                   |
| .eps                                | application/x-ps                        | .eps       | application/postscript              |
| .etd                                | application/x-ebx                       | .exe       | application/x-msdownload            |
| .fax                                | image/fax                               | .fdf       | application/vnd.fdf                 |
| .fif                                | application/fractals                    | .fo        | text/xml                            |
| .frm                                | application/x-frm                       | .g4        | application/x-g4                    |
| .gbr                                | application/x-gbr                       | .          | application/x-                      |
| .gif                                | image/gif                               | .gl2       | application/x-gl2                   |
| .gp4                                | application/x-gp4                       | .hgl       | application/x-hgl                   |
| .hmr                                | application/x-hmr                       | .hpg       | application/x-hpgl                  |
| .hpl                                | application/x-hpl                       | .hqx       | application/mac-binhex40            |
| .hrf                                | application/x-hrf                       | .hta       | application/hta                     |
| .htc                                | text/x-component                        | .htm       | text/html                           |
| .html                               | text/html                               | .htt       | text/webviewhtml                    |
| .htx                                | text/html                               | .icb       | application/x-icb                   |
| .ico                                | image/x-icon                            | .ico       | application/x-ico                   |
| .iff                                | application/x-iff                       | .ig4       | application/x-g4                    |
| .igs                                | application/x-igs                       | .iii       | application/x-iphone                |
| .img                                | application/x-img                       | .ins       | application/x-internet-signup       |
| .isp                                | application/x-internet-signup           | .IVF       | video/x-ivf                         |
| .java                               | java/*                                  | .jfif      | image/jpeg                          |
| .jpe                                | image/jpeg                              | .jpe       | application/x-jpe                   |
| .jpeg                               | image/jpeg                              | .jpg       | image/jpeg                          |
| .jpg                                | application/x-jpg                       | .js        | application/x-javascript            |
| .jsp                                | text/html                               | .la1       | audio/x-liquid-file                 |
| .lar                                | application/x-laplayer-reg              | .latex     | application/x-latex                 |
| .lavs                               | audio/x-liquid-secure                   | .lbm       | application/x-lbm                   |
| .lmsff                              | audio/x-la-lms                          | .ls        | application/x-javascript            |
| .ltr                                | application/x-ltr                       | .m1v       | video/x-mpeg                        |
| .m2v                                | video/x-mpeg                            | .m3u       | audio/mpegurl                       |
| .m4e                                | video/mpeg4                             | .mac       | application/x-mac                   |
| .man                                | application/x-troff-man                 | .math      | text/xml                            |
| .mdb                                | application/msaccess                    | .mdb       | application/x-mdb                   |
| .mfp                                | application/x-shockwave-flash           | .mht       | message/rfc822                      |
| .mhtml                              | message/rfc822                          | .mi        | application/x-mi                    |
| .mid                                | audio/mid                               | .midi      | audio/mid                           |
| .mil                                | application/x-mil                       | .mml       | text/xml                            |
| .mnd                                | audio/x-musicnet-download               | .mns       | audio/x-musicnet-stream             |
| .mocha                              | application/x-javascript                | .movie     | video/x-sgi-movie                   |
| .mp1                                | audio/mp1                               | .mp2       | audio/mp2                           |
| .mp2v                               | video/mpeg                              | .mp3       | audio/mp3                           |
| .mp4                                | video/mpeg4                             | .mpa       | video/x-mpg                         |
| .mpd                                | application/vnd.ms-project              | .mpe       | video/x-mpeg                        |
| .mpeg                               | video/mpg                               | .mpg       | video/mpg                           |
| .mpga                               | audio/rn-mpeg                           | .mpp       | application/vnd.ms-project          |
| .mps                                | video/x-mpeg                            | .mpt       | application/vnd.ms-project          |
| .mpv                                | video/mpg                               | .mpv2      | video/mpeg                          |
| .mpw                                | application/vnd.ms-project              | .mpx       | application/vnd.ms-project          |
| .mtx                                | text/xml                                | .mxp       | application/x-mmxp                  |
| .net                                | image/pnetvue                           | .nrf       | application/x-nrf                   |
| .nws                                | message/rfc822                          | .odc       | text/x-ms-odc                       |
| .out                                | application/x-out                       | .p10       | application/pkcs10                  |
| .p12                                | application/x-pkcs12                    | .p7b       | application/x-pkcs7-certificates    |
| .p7c                                | application/pkcs7-mime                  | .p7m       | application/pkcs7-mime              |
| .p7r                                | application/x-pkcs7-certreqresp         | .p7s       | application/pkcs7-signature         |
| .pc5                                | application/x-pc5                       | .pci       | application/x-pci                   |
| .pcl                                | application/x-pcl                       | .pcx       | application/x-pcx                   |
| .pdf                                | application/pdf                         | .pdf       | application/pdf                     |
| .pdx                                | application/vnd.adobe.pdx               | .pfx       | application/x-pkcs12                |
| .pgl                                | application/x-pgl                       | .pic       | application/x-pic                   |
| .pko                                | application/vnd.ms-pki.pko              | .pl        | application/x-perl                  |
| .plg                                | text/html                               | .pls       | audio/scpls                         |
| .plt                                | application/x-plt                       | .png       | image/png                           |
| .png                                | application/x-png                       | .pot       | application/vnd.ms-powerpoint       |
| .ppa                                | application/vnd.ms-powerpoint           | .ppm       | application/x-ppm                   |
| .pps                                | application/vnd.ms-powerpoint           | .ppt       | application/vnd.ms-powerpoint       |
| .ppt                                | application/x-ppt                       | .pr        | application/x-pr                    |
| .prf                                | application/pics-rules                  | .prn       | application/x-prn                   |
| .prt                                | application/x-prt                       | .ps        | application/x-ps                    |
| .ps                                 | application/postscript                  | .ptn       | application/x-ptn                   |
| .pwz                                | application/vnd.ms-powerpoint           | .r3t       | text/vnd.rn-realtext3d              |
| .ra                                 | audio/vnd.rn-realaudio                  | .ram       | audio/x-pn-realaudio                |
| .ras                                | application/x-ras                       | .rat       | application/rat-file                |
| .rdf                                | text/xml                                | .rec       | application/vnd.rn-recording        |
| .red                                | application/x-red                       | .rgb       | application/x-rgb                   |
| .rjs                                | application/vnd.rn-realsystem-rjs       | .rjt       | application/vnd.rn-realsystem-rjt   |
| .rlc                                | application/x-rlc                       | .rle       | application/x-rle                   |
| .rm                                 | application/vnd.rn-realmedia            | .rmf       | application/vnd.adobe.rmf           |
| .rmi                                | audio/mid                               | .rmj       | application/vnd.rn-realsystem-rmj   |
| .rmm                                | audio/x-pn-realaudio                    | .rmp       | application/vnd.rn-rn_music_package |
| .rms                                | application/vnd.rn-realmedia-secure     | .rmvb      | application/vnd.rn-realmedia-vbr    |
| .rmx                                | application/vnd.rn-realsystem-rmx       | .rnx       | application/vnd.rn-realplayer       |
| .rp                                 | image/vnd.rn-realpix                    | .rpm       | audio/x-pn-realaudio-plugin         |
| .rsml                               | application/vnd.rn-rsml                 | .rt        | text/vnd.rn-realtext                |
| .rtf                                | application/msword                      | .rtf       | application/x-rtf                   |
| .rv                                 | video/vnd.rn-realvideo                  | .sam       | application/x-sam                   |
| .sat                                | application/x-sat                       | .sdp       | application/sdp                     |
| .sdw                                | application/x-sdw                       | .sit       | application/x-stuffit               |
| .slb                                | application/x-slb                       | .sld       | application/x-sld                   |
| .slk                                | drawing/x-slk                           | .smi       | application/smil                    |
| .smil                               | application/smil                        | .smk       | application/x-smk                   |
| .snd                                | audio/basic                             | .sol       | text/plain                          |
| .sor                                | text/plain                              | .spc       | application/x-pkcs7-certificates    |
| .spl                                | application/futuresplash                | .spp       | text/xml                            |
| .ssm                                | application/streamingmedia              | .sst       | application/vnd.ms-pki.certstore    |
| .stl                                | application/vnd.ms-pki.stl              | .stm       | text/html                           |
| .sty                                | application/x-sty                       | .svg       | text/xml                            |
| .swf                                | application/x-shockwave-flash           | .tdf       | application/x-tdf                   |
| .tg4                                | application/x-tg4                       | .tga       | application/x-tga                   |
| .tif                                | image/tiff                              | .tif       | application/x-tif                   |
| .tiff                               | image/tiff                              | .tld       | text/xml                            |
| .top                                | drawing/x-top                           | .torrent   | application/x-bittorrent            |
| .tsd                                | text/xml                                | .txt       | text/plain                          |
| .uin                                | application/x-icq                       | .uls       | text/iuls                           |
| .vcf                                | text/x-vcard                            | .vda       | application/x-vda                   |
| .vdx                                | application/vnd.visio                   | .vml       | text/xml                            |
| .vpg                                | application/x-vpeg005                   | .vsd       | application/vnd.visio               |
| .vsd                                | application/x-vsd                       | .vss       | application/vnd.visio               |
| .vst                                | application/vnd.visio                   | .vst       | application/x-vst                   |
| .vsw                                | application/vnd.visio                   | .vsx       | application/vnd.visio               |
| .vtx                                | application/vnd.visio                   | .vxml      | text/xml                            |
| .wav                                | audio/wav                               | .wax       | audio/x-ms-wax                      |
| .wb1                                | application/x-wb1                       | .wb2       | application/x-wb2                   |
| .wb3                                | application/x-wb3                       | .wbmp      | image/vnd.wap.wbmp                  |
| .wiz                                | application/msword                      | .wk3       | application/x-wk3                   |
| .wk4                                | application/x-wk4                       | .wkq       | application/x-wkq                   |
| .wks                                | application/x-wks                       | .wm        | video/x-ms-wm                       |
| .wma                                | audio/x-ms-wma                          | .wmd       | application/x-ms-wmd                |
| .wmf                                | application/x-wmf                       | .wml       | text/vnd.wap.wml                    |
| .wmv                                | video/x-ms-wmv                          | .wmx       | video/x-ms-wmx                      |
| .wmz                                | application/x-ms-wmz                    | .wp6       | application/x-wp6                   |
| .wpd                                | application/x-wpd                       | .wpg       | application/x-wpg                   |
| .wpl                                | application/vnd.ms-wpl                  | .wq1       | application/x-wq1                   |
| .wr1                                | application/x-wr1                       | .wri       | application/x-wri                   |
| .wrk                                | application/x-wrk                       | .ws        | application/x-ws                    |
| .ws2                                | application/x-ws                        | .wsc       | text/scriptlet                      |
| .wsdl                               | text/xml                                | .wvx       | video/x-ms-wvx                      |
| .xdp                                | application/vnd.adobe.xdp               | .xdr       | text/xml                            |
| .xfd                                | application/vnd.adobe.xfd               | .xfdf      | application/vnd.adobe.xfdf          |
| .xhtml                              | text/html                               | .xls       | application/vnd.ms-excel            |
| .xls                                | application/x-xls                       | .xlw       | application/x-xlw                   |
| .xml                                | text/xml                                | .xpl       | audio/scpls                         |
| .xq                                 | text/xml                                | .xql       | text/xml                            |
| .xquery                             | text/xml                                | .xsd       | text/xml                            |
| .xsl                                | text/xml                                | .xslt      | text/xml                            |
| .xwd                                | application/x-xwd                       | .x_b       | application/x-x_b                   |
| .sis                                | application/vnd.symbian.install         | .sisx      | application/vnd.symbian.install     |
| .x_t                                | application/x-x_t                       | .ipa       | application/vnd.iphone              |
| .apk                                | application/vnd.android.package-archive | .xap       | application/x-silverlight-app       |

# Cookies

**Cookie是服务器发送到用户浏览器并保存在本地的一小块文本数据，浏览器会存储 Cookie 并在下次向同一服务器再发起请求时携带并发送到服务器上，用于跟踪用户与网站的互动、存储用户相关信息以及保持用户状态等**，Cookie 使基于无状态的 HTTP 协议记录稳定的状态信息成为了可能。

![img](https://pic3.zhimg.com/v2-9da617db58e1571cc456acae8df6c402_r.jpg)

响应标头 **`Set-Cookie`** 被用来由服务器端向客户端发送 Cookie，以便于客户端在后续的请求中将其发送回服务器识别身份使用。服务器如果要发送多个 cookie，则应该在同一响应中设置多个 **`Set-Cookie`** 标头。

**参数**

- **<cookie-name>=<cookie-value>**

一个有名称与值组成的键值对，用于表示需要传输的Cookie的名称以及值

![image-20240502232048130](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240502232048130.png)

![img](https://pic3.zhimg.com/80/v2-04bde0d82dc9f4e70cf6de4b87fd2402_720w.webp)

```http
// 会话期Cookie，将会在客户端关闭时被移除。会话期 cookie 不设置 Expires 或 Max-Age 属性。
Set-Cookie: sessionId=38afes7a8
// 持久化 cookie，不会在客户端关闭时失效，而是在特定的日期（Expires）或者经过一段特定的时间之后（Max-Age）才会失效。
Set-Cookie: id=a3fWa; Expires=Wed, 21 Oct 2015 07:28:00 GMT
Set-Cookie: id=a3fWa; Max-Age=2592000
// 限制域的Cookie
Set-Cookie:test=123;Domain=wangjunliang.com
// 一些名称包含了__Secure-、__Host-前缀的Cookie，当响应来自于一个安全域（HTTPS）的时候且设置了Secure属性，二者都可以被客户端接受
Set-Cookie: __Secure-ID=123; Secure; Domain=example.com
Set-Cookie: __Host-ID=123; Secure; Path=/
// 缺少 Secure 指令，会被拒绝
Set-Cookie: __Secure-id=1
// 名称包含了 __Host-前缀的cookie缺少 Path=/ 指令，会被拒绝
Set-Cookie: __Host-id=1; Secure
// 名称包含了 __Host-前缀的cookie由于设置了 domain 属性，会被拒绝
Set-Cookie: __Host-id=1; Secure; Path=/; domain=example.com
```

1. **URL中的片段部分 (Fragment Part of a URL)**
   - URL的片段部分是位于URL末尾的一个可选组成部分，以井号（#）开头。它通常用来指示Web页面中的一个特定部分，浏览器会滚动到该部分。例如，在URL `https://example.com/page#section2` 中，`#section2` 就是片段，指向页面中id为`section2`的部分 ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL))。
2. **HTTP客户端发送的Accept头部 (Accept Header)**
   - Accept头部是HTTP请求的一部分，用于告诉服务器客户端能够接收哪些类型的媒体内容。它可以包括多种类型，如`text/plain`，`image/jpeg`等，这样服务器就可以根据这些信息发送兼容的内容类型 ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL))。
3. **HTTP客户端发送的User-agent头部 (User-Agent Header)**
   - User-agent头部用于向服务器传达关于客户端软件的信息，包括浏览器类型、版本、操作系统等。每个浏览器都有自己独特的user-agent字符串。例如，Chrome浏览器可能发送类似于`Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36`的字符串 ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL))。
4. **URL中包含空格和特殊字符的编码 (Encoding Spaces and Special Characters in URLs)**
   - 在URL中，空格和一些特殊字符（如`<`, `>`, `#`, `%`, `{`, `}`, `|`, `\`, `^`, `~`, `[`, `]`, 和```）需要进行编码转换以避免解析错误。例如，空格通常编码为`%20`。这种编码称为URL编码或百分比编码 ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL))。
5. **布里斯托大学使用的Web服务器 (Web Server of University of Bristol)**
   - 根据HTTP头部信息，布里斯托大学的网站`www.bristol.ac.uk`使用的是Apache服务器。Apache是一个开源的Web服务器软件，由Apache软件基金会维护，它支持多种操作系统，因其稳定性、跨平台和安全性而广泛使用 ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL))。







# Internet

![Uploaded image](https://files.oaiusercontent.com/file-eFgB5LxfHbkUttZZ7IE0bhey?se=2024-05-03T00%3A08%3A51Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D299%2C%20immutable&rscd=attachment%3B%20filename%3Dimage.png&sig=lpIipjGum2JnErLph3W99We4S4atMNgdzvIIc4YodCA%3D)


这张图展示的是网络协议栈（Network Stack），也称为协议堆栈，它是一系列网络协议的层次化集合，每一层都负责处理网络通信的不同方面。图中从下到上的每一层分别代表了数据传输过程中所经历的各个阶段：

1. **IP层（Internet Protocol）**
   - IP地址：`137.222.0.38`
   - 这是网络层的基础，负责将数据包从源头传送到目的地。IP层使用IP地址来确定数据包的发送和接收位置。
2. **TCP层（Transmission Control Protocol）**
   - 端口号：`:80`
   - 位于传输层，TCP确保数据从一端传到另一端时的完整性和可靠性。它通过端口号来确定数据应当发送到接收方的哪个应用程序。
3. **TLS层（Transport Layer Security）**
   - 图中显示了一个锁的图标，表示安全性。
   - 这一层提供加密服务，保证数据在传输过程中的安全和隐私。TLS层位于会话层，用于在通信双方之间建立安全环境。
4. **HTTP层（Hypertext Transfer Protocol）**
   - 这是应用层的协议，用于Web浏览器和服务器之间的通信。HTTP定义了浏览器请求网页和服务器响应请求的具体格式。

底部的“computer architecture stuff”（计算机架构相关内容）可能指的是整个网络通信过程涉及的硬件和软件架构的底层细节，这包括数据如何在物理层面上被传输，以及支持网络协议栈运行的各种计算机系统组件。





HTTPS 协议栈与 HTTP 的唯一区别在于多了一个安全层（Security Layer）—— TLS/SSL，SSL 是最早的安全层协议，TLS 由 SSL 发展而来，所以下面我们统称 TLS。



- 数据包是网络中传输的基本单位，图中的“data packet”框展示了一个典型的IP数据包的结构，包括：
  - **源地址（source addr）**：发送方的IP地址。
  - **目的地址（dest addr）**：接收方的IP地址。
  - **数据（data）**：实际要发送的信息内容。

这张图非常直观地展示了TCP（传输控制协议，Transmission Control Protocol）的基本工作原理，尤其是如何处理数据包的传输和接收。

1. **分段和传输**：
   - 图的左上角的计算机表明，原始消息（蓝色长条）被分割成多个小数据包（标号为1到5）。这是TCP的一个关键特性，允许将大的数据块分割成更小、更易于管理的数据包进行网络传输。
2. **乱序传输**：
   - 数据包并不是按照顺序（1, 2, 3, 4, 5）传输的，而是可能以任何顺序到达目的地。如图所示，数据包的传输路径（通过网络中的路由器和交换机）可能导致它们到达目的地的顺序发生变化。这里，包5最先到达，其次是2, 4, 3, 1。
3. **重组数据包**：
   - 最右侧的服务器或终端设备需要根据TCP数据包的序号重新组合这些数据包，以恢复原始的消息内容。这保证了数据的完整性和顺序正确。

一个数据包的内部结构，包括序列号、校验和（checksum）、和数据内容。序列号用于确保数据包的顺序正确，校验和用于确保数据包在传输过程中的完整性没有被破坏。



1. **端口 80 - HTTP（超文本传输协议）**：
   - 端口80通常用于HTTP服务，即未加密的网页传输。当你在浏览器中输入一个网址并访问时，大部分情况下使用的就是端口80。
2. **端口 443 - TLS/SSL（传输层安全协议/安全套接层）**：
   - 端口443用于HTTPS服务，即加密的网页传输。这提供了一种安全的方式来浏览互联网，保护数据不被第三方窃取。
3. **端口 22 - SSH（安全壳协议）**：
   - 端口22用于SSH服务，这是一种提供加密的网络通信、远程命令执行和其他服务的协议。SSH广泛用于远程登录和文件传输。
4. **端口 8000, 8080等 - 开发（非官方端口）**：
   - 端口8000、8080等通常用于本地开发环境的Web服务器。它们不是官方指定的标准HTTP端口，但常常在开发过程中用于测试Web应用。



# ChatGPT讲TCP三次握手

TCP的三次握手（Three-Way Handshake）是一个确保两个设备在开始传输数据之前建立可靠连接的过程。这个过程不仅建立连接，而且同步双方的序列号和确认号，确保数据的准确传输。让我们通过一个简单的比喻来生动详细地解释这一过程：

### 比喻说明

假设你（客户端）打电话给一个朋友（服务器）约他出去玩。你们两个之间的对话就像是TCP的三次握手：

1. **你拨打电话给朋友**：
   - 这相当于TCP连接的**第一次握手**，你（客户端）发送一个带有SYN（同步序列编号）标志的数据包，告诉你的朋友：“嘿，我想和你出去玩，我们从编号100开始聊天吧。”这里的编号100是一个序列号，用于跟踪应该首先传送哪个数据包。

2. **你的朋友接电话并回应**：
   - 这是**第二次握手**。你的朋友（服务器）接到你的电话后回复说：“好的，我知道了。我们从编号100开始聊天吧。对了，你听到我的回复了吗？从编号300开始回复我。”这里，朋友的回复包含了ACK（确认）和SYN标志，ACK 101表示他准备好从你的序列号101接收数据，同时用SYN 300告诉你他的开始序列号。

3. **你确认你的朋友的回应**：
   - 这是**第三次握手**。你回复你的朋友：“我听到你的回复了，我们从编号300开始你的话题。”这条消息带有ACK标志，确认号设为301，表示你已经准备好接收编号301及之后的消息。

### 结果

现在，你和你的朋友已经确认了彼此的存在，知道了从哪里开始对话，并同意了如何继续通信。这样，即使网络不稳定导致消息需要重新发送，你们也能确保对话内容的正确性和完整性。

### 技术解释

- **SYN（Synchronize）**：同步序列号以开始一个新的连接。
- **ACK（Acknowledge）**：确认收到对方的消息。
- **序列号**：标识从TCP源到TCP目的地的字节流的顺序。
- **确认号**：表示到目前为止已成功接收的数据，并期望下一个数据的序列号。

通过这样的三次握手，TCP协议能够在不可靠的互联网上提供稳定可靠的数据传输服务。





# HTML

![一个示范性的代码片断，展示了 html 元素 <p> My cat is very grumpy </p> 的结构。](https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML/Getting_started/grumpy-cat-small.png)

在 HTML 中有以下空元素：

- `<area>` 

- `base`

- `br`

- `col`

- `embed`

- `hr`

- `img`

- `input`

- `link`

- `meta`

- `param`

- `source`

- `track`

- `wbr`

  空元素只有开始标签且不能指定结束标签。

  ![含有‘class="editor-note"’属性的段落标签](https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML/Getting_started/grumpy-cat-attribute-small.png)

属性必须包含：

- 一个空格，它在属性和元素名称之间。如果一个元素具有多个属性，则每个属性之间必须由空格分隔。

- 属性名称，后面跟着一个等于号。

- 一个属性值，由一对引号（""）引起来。

  

  

  

  **`<a>`** 元素（或称*锚*元素）可以通过[它的 `href` 属性](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/a#href)创建通向其他网页、文件、电子邮件地址、同一页面内的位置或任何其他 URL 的超链接。



# 查文档

``````bash
tar -zxvf developer.mozilla.org.tar.gz 
``````

这里我们有：

1. ```
   <!DOCTYPE html>
   ```

   : 声明文档类型。早期的 HTML（大约 1991-1992 年）文档类型声明类似于链接，规定了 HTML 页面必须遵从的良好规则，能自动检测错误和其他有用的东西。文档类型使用类似于这样：

   HTMLCopy to Clipboard

   ```
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
   ```

   文档类型是一个历史遗留问题，需要包含它才能使其他东西正常工作。现在，只需要知道

    

   ```
   <!DOCTYPE html>
   ```

    

   是最短的有效文档声明！

2. `<html></html>`: [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/html) 元素。这个元素包裹了页面中所有的内容，有时被称为根元素。

3. `<head></head>`: [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/head) 元素。这个元素是一个容器，它包含了所有你想包含在 HTML 页面中但**不在 HTML 页面中显示**的内容。这些内容包括你想在搜索结果中出现的关键字和页面描述、CSS 样式、字符集声明等等。以后的章节中会学到更多相关的内容。

4. `<meta charset="utf-8">`: [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/meta) 元素。这个元素代表了不能由其他 HTML 元相关元素表示的元数据，比如 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/base)、[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/link)、[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/script)、[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/style) 或 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/title)。[`charset`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/meta#charset) 属性将你的文档的字符集设置为 UTF-8，其中包括绝大多数人类书面语言的大多数字符。有了这个设置，页面现在可以处理它可能包含的任何文本内容。没有理由不对它进行设置，它可以帮助避免以后的一些问题。

5. `<title></title>`: [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/title) 元素。这设置了页面的标题，也就是出现在该页面加载的浏览器标签中的内容。当页面被加入书签时，页面标题也被用来描述该页面。

6. `<body></body>`: [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/body) 元素。包含了你访问页面时*所有*显示在页面上的内容，包含文本、图片、视频、游戏、可播放音频轨道等等。

```html
<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>我的测试站点</title>
  </head>
  <body>
    <p>这是我的页面</p>
  </body>
</html>
```

![image-20240503103223751](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240503103223751.png)

上面的例子展示了 `<img>` 元素的用法：

- `src` 属性是**必须的**，它包含了你想嵌入的图片的路径。
- `alt` 属性包含一条对图像的文本描述，这不是强制性的，但对无障碍而言，它**难以置信地有用**——屏幕阅读器会将这些描述读给需要使用阅读器的使用者听，让他们知道图像的含义。如果由于某种原因无法加载图像，普通浏览器也会在页面上显示 `alt` 属性中的备用文本：例如，网络错误、内容被屏蔽或链接过期。



## 实体引用：在 HTML 中包含特殊字符

在 HTML 中，字符 `<`、`>`、`"`、`'` 和 `&` 是特殊字符。它们是 HTML 语法自身的一部分，那么你如何将这些字符包含进你的文本中呢，比如说如果你真的想要在文本中使用符号 `&` 或者小于号，而不想让它们被浏览器视为代码并被解释？

我们必须使用字符引用——表示字符的特殊编码，它们可以在那些情况下使用。每个字符引用以符号 & 开始，以分号（;）结束。

| 原义字符 | 等价字符引用 |
| :------- | :----------- |
| <        | `<`          |
| >        | `>`          |
| "        | `"`          |
| '        | `'`          |
| &        | `&`          |

无序的清单从`<ul>`元素开始，需要包裹清单上所有被列出的项目：

HTMLCopy to Clipboard

```html
<ul>
  豆浆
  油条
  豆汁
  焦圈
</ul>
```

然后就是用`<li>`元素把每个列出的项目单独包裹起来：

HTMLCopy to Clipboard

```html
<ul>
  <li>豆浆</li>
  <li>油条</li>
  <li>豆汁</li>
  <li>焦圈</li>
</ul>
```

有序列表需要按照项目的顺序列出来,标记的结构和无序列表一样，除了需要用`<ol>` 元素将所有项目包裹，而不是 `<ul>`：

```html
<ol>
  <li>沿这条路走到头</li>
  <li>右转</li>
  <li>直行穿过第一个十字路口</li>
  <li>在第三个十字路口处左转</li>
  <li>继续走 300 米，学校就在你的右手边</li>
</ol>
```



超链接除了可以链接到文档外，也可以链接到 HTML 文档的特定部分（被称为**文档片段**）。要做到这一点，你必须首先给要链接到的元素分配一个 [`id`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Global_attributes#id) 属性。通常情况下，链接到一个特定的标题是有意义的，这看起来就像下面这样：
```<h2 id="Mailing_address">邮寄地址</h2>```

为了链接到那个特定的 `id`，要将它放在 URL 的末尾，并在前面包含井号（`#`），例如：

```html
<p>
  要提供意见和建议，请将信件邮寄至<a href="contacts.html#Mailing_address"
    >我们的地址</a
  >。
</p>

```

你甚至可以在同一份文档下，通过链接文档片段，来链接到*当前文档的另一部分*：

```html
<p>本页面底部可以找到<a href="#Mailing_address">公司邮寄地址</a>。</p>

```





在HTML中，`<section>`, `<span>`, 和 `<div>` 是常用的标签，它们在组织和布局网页内容时发挥着重要作用。下面详细解释每个标签的用法：

### `<section>`

`<section>` 标签用于定义文档或应用的一个区段。通常，它用来组织页面的大块区域，有助于通过逻辑区分来增强文档的结构。`<section>` 通常包含一组内容及其标题，例如一个章节、页眉、页脚或页面中的其他部分。

**用法示例**：

```html
<section>
  <h1>章节标题</h1>
  <p>这里是一些介绍性的文本。</p>
</section>
```

这样的结构有助于搜索引擎和浏览器理解页面内容的结构。

### `<span>`

`<span>` 是一个通用的行内容器标签，它本身不表示任何特定意义。它主要用于对文本的小块部分应用样式或其他属性，如改变颜色、字体或为文本添加特效。

**用法示例**：

```html
<p>我是一段文本，这是<span style="color: red;">红色</span>的词。</p>
```

在这个例子中，`<span>` 被用来将文本中的一个词变成红色。

### `<div>`

<div> 是一个非常通用的块级容器，它用于创建HTML文档中的逻辑容器。<div> 元素通常作为其他HTML元素的容器，用来构建网页布局或者将页面分区，常常与CSS一起使用来管理布局。

**用法示例**：

```html
<div id="header">
  <h1>网页标题</h1>
</div>
```

这里，`<div>` 用于创建一个页面的头部区域，并可以通过CSS对其进行样式设计。

总的来说，这三个标签在网页布局和内容组织中扮演着核心角色，使得网页的结构更加清晰，同时便于样式的控制和内容的呈现。在HTML中，`<section>`, `<span>`, 和 `<div>` 是常用的标签，它们在组织和布局网页内容时发挥着重要作用。下面详细解释每个标签的用法：

### `<section>`

`<section>` 标签用于定义文档或应用的一个区段。通常，它用来组织页面的大块区域，有助于通过逻辑区分来增强文档的结构。`<section>` 通常包含一组内容及其标题，例如一个章节、页眉、页脚或页面中的其他部分。

**用法示例**：

```
htmlCopy code<section>
  <h1>章节标题</h1>
  <p>这里是一些介绍性的文本。</p>
</section>
```

这样的结构有助于搜索引擎和浏览器理解页面内容的结构。

### `<span>`

`<span>` 是一个通用的行内容器标签，它本身不表示任何特定意义。它主要用于对文本的小块部分应用样式或其他属性，如改变颜色、字体或为文本添加特效。

**用法示例**：

```
html
Copy code
<p>我是一段文本，这是<span style="color: red;">红色</span>的词。</p>
```

在这个例子中，`<span>` 被用来将文本中的一个词变成红色。

### `<div>`

<div> 是一个非常通用的块级容器，它用于创建HTML文档中的逻辑容器。<div> 元素通常作为其他HTML元素的容器，用来构建网页布局或者将页面分区，常常与CSS一起使用来管理布局。

**用法示例**：

```
htmlCopy code<div id="header">
  <h1>网页标题</h1>
</div>
```

这里，`<div>` 用于创建一个页面的头部区域，并可以通过CSS对其进行样式设计。

总的来说，这三个标签在网页布局和内容组织中扮演着核心角色，使得网页的结构更加清晰，同时便于样式的控制和内容的呈现。



```html
 <form method="post" action="/comment">
      <p>
      	<label for="name">Name:</label>
     	<input id="name" name="name"/>
      </p>
      <p>
      	<button type="submit">OK</button>
      </p>
</form>
```



- `id="name"` 属性给输入字段定义一个唯一的标识符，与`<label>`的`for`属性相对应，链接标签和输入框。
- `name="name"` 属性定义了输入数据字段的名称，这是在提交表单时，服务器端接收数据使用的字段名。







在[前一篇文章](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/Basic_native_form_controls)中我们学习了 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 元素，涵盖了自 HTML 早期以来可用的 `type` 属性的原始值。现在我们来具体看一看较新的表单控件，包含一些新添加至 HTML 5 的 input 类型，以允许收集更多特定类型的数据。

| 前提： | 计算机基础知识和对于 [HTML 的基本理解](https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML)。 |
| :----- | ------------------------------------------------------------ |
| 目标： | 了解可用于创建本地表单控件的较新的 input 类型值，以及如何使用 HTML 实现它们。 |

**备注：** 本篇文章中讨论的大多数特性都受到了广泛支持，如果有任何例外将会在文章中说明，如果你需要更多浏览器支持的细节，你应该查看我们的 [HTML 表单元素参考](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element#forms)，特别是深入的 [ 类型](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 参考。

由于 HTML 表单控件的外观可能与设计者的规格有很大的不同，web 开发者有时会建立自己的自定义表单控件。我们在一个高级教程中介绍了这一点：[如何构建自定义表单控件](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/How_to_build_custom_form_controls)。

## [E-mail 地址字段](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#e-mail_地址字段)

将 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 属性设置为 `email` 就可以使用这种控件：

HTMLCopy to Clipboard

```
<input type="email" id="email" name="email" />
```

当使用了这种 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 类型时，用户需要输入一个合法的电子邮件地址，任何其他输入都会使得浏览器在表单提交时显示错误信息。你可以在下面的截图中看到这个行为：

![An invalid email input showing the message "Please enter an email address."](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/email_address_invalid.png)

你也可以搭配使用 [`multiple`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/multiple) 属性，以允许在同一个 `email` 输入框中输入多个电子邮件地址，以英文逗号分隔：

```
<input type="email" id="email" name="email" multiple />
```

在某些设备上——特别是像智能手机这样具有动态键盘的触摸设备——可能会出现一个包括 `@` 键的更适合于输入电子邮件地址的虚拟键盘。请看下面的 Firefox Android 版键盘截图，以示说明：

![Firefox for Android email keyboard, with the at sign displayed by default.](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/fx-android-email-type-keyboard.jpg)

**备注：** 你可以在[基本 input 例子](https://mdn.github.io/learning-area/html/forms/basic-input-examples/)中找到基本文本 input 类型的例子（也请看看[源代码](https://github.com/mdn/learning-area/blob/main/html/forms/basic-input-examples/index.html)）。

这是使用这些较新的 input 类型的另一个很好的理由——可以为这些设备的用户改善用户体验。

### [客户端验证](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#客户端验证)

正如你在上面看到的，`email` 与其他较新的 `input` 类型一样，提供了内置的*客户端*错误验证，在数据被发送到服务器之前由浏览器执行。它*是*引导用户准确填写表格的一个有用的辅助工具，可以节省时间：可以立即知道你的数据是否正确，而不需要等待服务器返回结果。

但它*不应该*被认为是一种详尽的安全措施！你的应用程序始终应该在*服务器端*和客户端对任何表单提交的数据进行安全检查，因为客户端验证太容易被关闭了，所以恶意用户仍然可以很容易地将坏数据发送到你的服务器。请参阅[网站安全](https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/First_steps/Website_security)来了解*可能*会发生什么。实现服务端认证超出了本章的范围，但你应该熟稔于心。

注意，在默认限制条件下，`a@b` 也是一个合法的电子邮件地址，因为 `email` input 类型默认也允许内部网络的电子邮件地址。为了实现不同的验证行为，你可以使用 [`pattern`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Attributes/pattern) 属性，而且可以自定义错误信息；我们将在[客户端表单认证](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/Form_validation)文章中进一步说明如何使用这些功能。

**备注：** 如果输入的数据不是一个电子邮件地址，会匹配 [`:invalid`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/:invalid) 伪类，且 [`validityState.typeMismatch`](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/typeMismatch) 属性总会返回 `true`。

## [查询字段](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#查询字段)

查询字段（Search fields）旨在用于在页面和应用程序上创建搜索框。将 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 属性设置为 `search` 就可以使用这种控件：

```
<input type="search" id="search" name="search" />
```

`text` 字段和 `search` 字段的主要区别是浏览器赋予它们的外观显示。通常情况下，`search` 字段拥有圆角边框，有时会显示“Ⓧ”标志，当点击它时会清除输入框。另外，在动态键盘设备上，键盘的回车键会显示“**search**”，或显示为放大镜图标。

下面的截图显示了 macOS 上的 Firefox 71、Safari 13 和 Chrome 79，以及 Windows 10 上的 Edge 18 和 Chrome 79 的非空查询字段，请注意，清除图标仅当在输入框中存在值得时候才会显示，且与 Safari 不同的是，仅当聚焦状态时才会显示此图标。

![Screenshots of search fields on several platforms.](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/search_focus.png)

另外一个值得提示的特性是，`search` 字段的值可以自动地保存下来，在同一网站的自动完成框中复用输入，这样的特性倾向于在大多数现代浏览器中自动进行。

## [电话号码字段](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#电话号码字段)

在 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 属性中使用 `tel` 值，即可创建一个专门用于输入电话号码的文本域：

```
<input type="tel" id="tel" name="tel" />
```

当使用带有动态键盘的移动设备访问带有 `type="tel"` 的表单时，大多数设备会显示数字键盘。这意味着只要数字键盘有用，这种类型就很有用，而且不只是用于电话号码。

下方截图为在 Android 系统的 Firefox 浏览器上访问该类型表单的键盘：

![Firefox for Android email keyboard, with ampersand displayed by default.](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/fx-android-tel-type-keyboard.jpg)

由于世界各地的电话号码格式多种多样，这种类型的字段对用户输入的值没有任何限制（这意味着它可能包括字母等非数字值）。

像之前提及的那样，[`pattern`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Attributes/pattern) 属性也可以应用在这里来附加一些限制，你会在[客户端表单验证](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/Form_validation)文章中学到更多内容。

## [URL 字段](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#url_字段)

在 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 属性值中使用 `url`，即可创建一个用于输入网址的文本字段：

```
<input type="url" id="url" name="url" />
```

它为字段添加了特殊的验证约束。浏览器会在没有协议（例如 `http:`）输入或网址格式不对的情况下报告错误。在具有动态键盘的设备上，键盘通常会显示部分或全部冒号、句号和正斜杠作为默认键。

看看下面这个例子（取自于 Android 上的 Firefox 浏览器)：

![Firefox for Android email keyboard, with ampersand displayed by default.](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/fx-android-url-type-keyboard.jpg)

**备注：** URL 格式正确可不意味着所指向的地址一定实际存在！

## [数字字段](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#数字字段)

用于输入数字的控件可以由 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 为 `number` 的 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 元素创建。这个控件外观与文本域类似，但只允许浮点数输入，并通常以旋转器（spinner）的形式提供按钮来增加和减少控件的值。在有动态键盘的设备上，一般会显示数字键盘。

看看下面这个例子（取自于 Android 上的 Firefox 浏览器)：

![Firefox for Android email keyboard, with ampersand displayed by default.](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types/fx-android-number-type-keyboard.jpg)

使用 `number` input 类型，你可以使用 [`min`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#min) 和 [`max`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#max) 属性控制允许输入的最小值和最大值。

你也可以使用 `step` 属性来设定每次按下 spinner 按钮增加或减少的值。默认情况下，number input 类型只允许整数值输入，为了允许浮点数输入，要指定 [`step="any"`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/step)。如果省略了此值，`step` 会默认为 `1`，意味着只有自然数是有效的输入。

我们来看一些例子。第一个例子创建了可从 `1` 到 `10` 之间选择值的数字选择器，且单击一次按钮所增长或减少的值为 `2`。

```
<input type="number" name="age" id="age" min="1" max="10" step="2" />
```

第二个例子创建了可从 `0` 到 `1` 之间选择值得数字选择器，且单击一次按钮所增长或减少的值为 `0.01`。

```
<input type="number" name="change" id="pennies" min="0" max="1" step="0.01" />
```

当有效值的范围有限时，`number` 输入类型才有意义，例如一个人的年龄或身高。如果范围太大，渐进式增加没有意义（如范围为 `00001` 到 `99999` 的美国 ZIP 码）的话，使用 `tel` 类型可能会更好；它提供了数字键盘，而放弃了数字输入器的 spinner UI 功能。

## [滑块控件](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#滑块控件)

另外一种选择数字的方式是使用**滑块（slider）**。你在买房网站等网站上经常看到这种情况，你想设置一个最高的房产价格来进行过滤。让我们看一个现场示例来说明这一点：

```html
<iframe width="100%" height="200" 
        src="https://mdn.github.io/learning-area/html/forms/range-example/index.html" 
        loading="lazy" 
        style="box-sizing: content-box; border: 1px solid var(--border-primary); max-width: 100%; width: calc(100% - 2px - 2rem); background: rgb(255, 255, 255); border-radius: var(--elem-radius); padding: 1rem;">
</iframe>
```



<iframe width="100%" height="200" src="https://mdn.github.io/learning-area/html/forms/range-example/index.html" loading="lazy" style="box-sizing: content-box; border: 1px solid var(--border-primary); max-width: 100%; width: calc(100% - 2px - 2rem); background: rgb(255, 255, 255); border-radius: var(--elem-radius); padding: 1rem;"></iframe>

从使用上来说，滑块的准确性不如文本字段。因此，它们被用来挑选*精确值*不一定那么重要的数字。

在 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 元素中使用 `range` 作为属性 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 的值，就可以创建一个滑块，滑块可以通过鼠标、触摸，或用键盘的方向键移动。

正确配置滑块组件非常重要。推荐分别配置 [`min`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min)、[`max`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max) 和 [`step`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/step) 属性来设置滑块的最小值、最大值和增量值。

我们来看看示例背后的代码，这样你就可以看到它是如何完成的。首先是基本的 HTML 代码：

HTMLCopy to Clipboard

```
<label for="price">Choose a maximum house price: </label>
<input
  type="range"
  name="price"
  id="price"
  min="50000"
  max="500000"
  step="100"
  value="250000" />
<output class="price-output" for="price"></output>
```

本示例创建了一个其取值为 `50000` 到 `500000` 之间的滑块，每次的增量值是 100。我们使用 `value` 属性设定了此滑块的默认值为 `250000`。

使用滑块的一个问题是，它们不提供任何种类的视觉反馈来说明当前的值是什么。这是我们附加了一个包含当前值输出的 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/output) 元素的原因。你可以在任何元素内显示一个输入值或一个计算的输出值，但是 `<output>` 是特殊的，就像 `<label>` 那样，它可以指定 `for` 属性，允许你将它与输出值来自的一个或多个元素联系起来。

要真正显示当前值，并在其变化时更新，你必须使用 JavaScript，这相对容易做到：

JSCopy to Clipboard

```
const price = document.querySelector("#price");
const output = document.querySelector(".price-output");

output.textContent = price.value;

price.addEventListener("input", () => {
  output.textContent = price.value;
});
```

这里我们将 `range` 输入元素和 `output` 元素存为了两个变量。然后我们马上将 `output` 的 [`textContent`](https://developer.mozilla.org/zh-CN/docs/Web/API/Node/textContent) 属性设置为 input 的 `value` 。最终，我们设置了一个事件监听器，确保每次范围滑块移动时，`output` 的 `textContent` 总是可以及时更新为新值。

**备注：** 在 CSS Tricks 网站上有一篇关于该主题的很好的教程：[The Output Element](https://css-tricks.com/the-output-element/)。

## [日期和时间选择器](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#日期和时间选择器)

收集日期和时间值历来是 web 开发者的噩梦。为了获得良好的用户体验，提供一个日历选择用户界面是很重要的，使用户能够选择日期，而不需要切换到本地日历应用程序的上下文，或者可能以难以解析的不同格式输入。上个千年（1000~1999 年）的最后一分钟可以用以下不同的方式表示，例如：1999/12/31，23:59 或 12/31/99T11:59PM。

HTML 日期控件可用于处理这种特定的数据，提供日历控件并使数据统一。

日期和时间控件可由 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 元素和一个合适的 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 属性值来创建，该值取决于要收集的类型（日期、时间、还是以上全部）。这里有一个示例，在浏览器不支持的情况下会自动回退为 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/select) 元素：

<iframe width="100%" height="200" src="https://mdn.github.io/learning-area/html/forms/datetime-local-picker-fallback/index.html" loading="lazy" style="box-sizing: content-box; border: 1px solid var(--border-primary); max-width: 100%; width: calc(100% - 2px - 2rem); background: rgb(255, 255, 255); border-radius: var(--elem-radius); padding: 1rem;"></iframe>

让我们简单地看看不同的可用类型。请注意，这些类型的用法相当复杂，特别是考虑到浏览器的支持（见下文）；要想了解全部细节，请跟随下面的链接进入到每种类型的参考页面，包括详细的例子。

### [`datetime-local`](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#datetime-local)

[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input/datetime-local) 创建了显示和选择一个没有特定时区信息的日期和时间的控件。

HTMLCopy to Clipboard

```
<input type="datetime-local" name="datetime" id="datetime" />
```

### [`month`](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#month)

[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input/month) 创建了显示和选择带有年份信息的某个月的控件。

HTMLCopy to Clipboard

```
<input type="month" name="month" id="month" />
```

### [`time`](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#time)

[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input/time) 创建了显示和选择时间的控件。时间可能会以 *12 小时制*显示，但一定会以 *24 小时制*形式返回。

HTMLCopy to Clipboard

```
<input type="time" name="time" id="time" />
```

### [`week`](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#week)

[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input/week) 创建了显示和选择一年中特定编号周的控件。

一周以周一开始，一直运行到周日结束。另外，每年的第一周总会包含那一年首个星期四，其中可能不包括当年的第一天，也可能包括前一年的最后几天。

HTMLCopy to Clipboard

```
<input type="week" name="week" id="week" />
```

### [限制日期/时间值](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#限制日期时间值)

所有的日期和时间控件总可以由 [`min`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min) 和 [`max`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max) 属性控制，可由 [`step`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/step) 属性进一步做控制，具体值随着 input 类型的不同而产生变化。

HTMLCopy to Clipboard

```
<label for="myDate">When are you available this summer?</label>
<input
  type="date"
  name="myDate"
  min="2013-06-01"
  max="2013-08-31"
  step="7"
  id="myDate" />
```

## [颜色选择器控件](https://developer.mozilla.org/zh-CN/docs/Learn/Forms/HTML5_input_types#颜色选择器控件)

颜色总是有点难处理。有许多方法来表达它们，如 RGB 值（十进制或十六进制）、HSL 值、关键词等。

用于输入颜色的控件可以由 [`type`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input#type) 为 `color` 的 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/input) 元素创建：

HTMLCopy to Clipboard

```
<input type="color" name="color" id="color" />
```

在支持的情况下，点击一个颜色控件将倾向于显示操作系统的默认颜色选择功能，以便你真正做出选择。以下是在 macOS 上 Firefox 浏览器的屏幕截图，提供了一个例子：

这里有一个在线示例供你尝试：

```html
<iframe width="100%" height="200" src="https://mdn.github.io/learning-area/html/forms/color-example/index.html" loading="lazy" style="box-sizing: content-box; border: 1px solid var(--border-primary); max-width: 100%; width: calc(100% - 2px - 2rem); background: rgb(255, 255, 255); border-radius: var(--elem-radius); padding: 1rem;"></iframe>
```



<iframe width="100%" height="200" src="https://mdn.github.io/learning-area/html/forms/color-example/index.html" loading="lazy" style="box-sizing: content-box; border: 1px solid var(--border-primary); max-width: 100%; width: calc(100% - 2px - 2rem); background: rgb(255, 255, 255); border-radius: var(--elem-radius); padding: 1rem;"></iframe>

返回值总是颜色的小写的 6 位十六进制数表示。







# CSS

为了把 `styles.css` 和 `index.html` 连接起来，可以在 HTML 文档中，[``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/head) 语句模块里面加上下面的代码：

```html
<link rel="stylesheet" href="styles.css" />
```

`<link>`语句块里面，我们用属性 `rel`，让浏览器知道有 CSS 文档存在（所以需要遵守 CSS 样式的规定），并利用属性 `href` 指定，寻找 CSS 文件的位置。你可以做测试来验证 CSS 是否有效：在 `styles.css` 里面加上 CSS 样式并观察显示的结果。下面，用你的编辑器打出下面的代码。

CSSCopy to Clipboard

```css
h1 {
  color: red;
}
```

## [根据状态确定样式](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/First_steps/Getting_started#根据状态确定样式)

在这篇教程中我们最后要看的一种修改样式的方法就是根据标签的状态确定样式。一个直观的例子就是当我们修改链接的样式时。当我们修改一个链接的样式时我们需要定位（针对） [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/a) （锚）标签。取决于是否是未访问的、访问过的、被鼠标悬停的、被键盘定位的，亦或是正在被点击当中的状态，这个标签有着不同的状态。你可以使用 CSS 去定位或者说针对这些不同的状态进行修饰——下面的 CSS 代码使得没有被访问的链接颜色变为粉色、访问过的链接变为绿色。

```css
a:link {
  color: pink;
}

a:visited {
  color: green;
}
```

你可以改变链接被鼠标悬停的时候的样式，例如移除下划线，下面的代码就实现了这个功能。

```css
a:hover {
  text-decoration: none;
}
```



组合使用

```css
/* selects any <span> that is inside a <p>, which is inside an <article>  */
article p span { ... }

/* selects any <p> that comes directly after a <ul>, which comes directly after an <h1>  */
h1 + ul + p { ... }

```

下面的代码为以下元素建立样式：在 `<body>` 之内，紧接在 `<h1>` 后面的 `<p>` 元素的内部，类名为 special。

```css
body h1 + p .special {
  color: yellow;
  background-color: black;
  padding: 5px;
}

```





一个内部样式表驻留在 HTML 文档内部。要创建一个内部样式表，你要把 CSS 放置在包含在head元素中的 style元素内

```html
<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>我的 CSS 测试</title>
    <style>
      h1 {
        color: blue;
        background-color: yellow;
        border: 1px solid black;
      }
      p {
        color: red;
      }
    </style>
  </head>
  <body>
    <h1>Hello World!</h1>
    <p>这是我的第一个 CSS 示例</p>
  </body>
</html>
```



<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>我的 CSS 测试</title>
    <style>
      h1 {
        color: blue;
        background-color: yellow;
        border: 1px solid black;
      }
      p {
        color: red;
      }
    </style>
  </head>
  <body>
    <h1>Hello World!</h1>
    <p>这是我的第一个 CSS 示例</p>
  </body>
</html>

内联样式是影响单个 HTML 元素的 CSS 声明，包含在元素的 `style` 属性中。在一个 HTML 文档中，内联样式的实现可能看起来像这样

```html
<body>
    <h1 style="color: blue;background-color: yellow;border: 1px solid black;">
      Hello World!
    </h1>
    <p style="color:red;">这是我的第一个 CSS 示例</p> 
</body>
```

<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>我的 CSS 测试</title>
  </head>
  <body>
    <h1 style="color: blue;background-color: yellow;border: 1px solid black;">
      Hello World!
    </h1>
    <p style="color:red;">这是我的第一个 CSS 示例</p>
  </body>
</html>

在最基本的层面上，CSS 由两个组成部分组成：

- **属性**：人类可读的标识符，指示想要更改的样式特征。如 [`font-size`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/font-size)、[`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width)、[`background-color`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-color)。

- **值**：每个指定的属性都有一个值，这个值表示如何对属性施加样式。

  

  ![一个突出的 CSS 样式](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/First_steps/How_CSS_is_structured/declaration.png)

  CSS 的 [`@rules`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/At-rule)（读作“at-rules”）是一些特殊的规则，提供了关于 CSS 应该执行什么或如何表现的指令。例如，`@import` 将一个样式表导入另一个 CSS 样式表：

  ```css
  @import "styles2.css";
  ```

  样式表为 `<body>` 元素定义了一个默认的粉红色背景。然而，如果浏览器的视口宽于 30em，接下来的媒体查询则定义了蓝色背景。

  ```css
  body {
    background-color: pink;
  }
  
  @media (min-width: 30em) {
    body {
      background-color: blue;
    }
  }
  
  ```

  等价的两段代码

  ```css
     /* 数值的应用顺序是上、右、下、左（从顶部顺时针方向）。
     也有其他的简写类型，例如 2 值简写，
     它为顶部/底部设置 padding/margin，然后是左侧/右侧 */
  padding: 10px 15px 15px 5px;
  ```

  ```css
  padding-top: 10px;
  padding-right: 15px;
  padding-bottom: 15px;
  padding-left: 5px;
  ```

  **`padding`** [CSS](https://developer.mozilla.org/zh-CN/docs/Web/CSS) [简写属性](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Shorthand_properties)一次性设置元素所有四条边的[内边距区域](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_box_model/Introduction_to_the_CSS_box_model#内边距区域)。



# **接续兄弟选择器**

（`+`）介于两个选择器之间，当第二个元素*紧跟在*第一个元素之后，并且两个元素都是属于同一个父[元素](https://developer.mozilla.org/zh-CN/docs/Web/API/Element)的子元素，则第二个元素将被选中。

CSSCopy to Clipboard

```
/* 图片后面紧跟着的段落将被选中 */
img + p {
  font-weight: bold;
}
```

## [语法](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Next-sibling_combinator#语法)

```
former_element + target_element { style properties }
```

## [示例](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Next-sibling_combinator#示例)

### [CSS](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Next-sibling_combinator#css)

```css
li:first-of-type + li {
  color: red;
}
```

### [HTML](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Next-sibling_combinator#html)

```html
<ul>
  <li>One</li>
  <li>Two!</li>
  <li>Three</li>
</ul>
```

# 后续兄弟选择器

**后续兄弟选择器**（`~`）将两个选择器分开，并匹配第二个选择器的*所有迭代元素*，位置无须紧邻于第一个元素，只须有相同的父级[元素](https://developer.mozilla.org/zh-CN/docs/Glossary/Element)。

CSSCopy to Clipboard

```
/* 在任意图像后的兄弟段落 */
img ~ p {
  color: red;
}
```

## [语法](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Subsequent-sibling_combinator#语法)

```
former_element ~ target_element { style properties }
```

## [示例](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Subsequent-sibling_combinator#示例)

### [CSS](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Subsequent-sibling_combinator#css)

```
p ~ span {
  color: red;
}
```

### [HTML](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Subsequent-sibling_combinator#html)

```
<span>This is not red.</span>
<p>Here is a paragraph.</p>
<code>Here is some code.</code>
<span>And here is a red span!</span>
<span>And this is a red span!</span>
<code>More code…</code>
<div>How are you?</div>
<p>Whatever it may be, keep smiling.</p>
<h1>Dream big</h1>
<span>And yet again this is a red span!</span>
```

# **子组合器**

（`>`）被放在两个 CSS 选择器之间。它只匹配那些被第二个选择器匹配的元素，这些元素是被第一个选择器匹配的元素的直接子元素。

CSSCopy to Clipboard

```
/* 选择属于“my-things”类的无序列表（ul）的直接子列表元素（li） */
ul.my-things > li {
  margin: 2em;
}
```

被第二个选择器匹配的元素必须是被第一个选择器匹配的元素的直接子元素。这比[后代组合器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Descendant_combinator)更严格，后者匹配所有被第二个选择器匹配的元素，这些元素存在被第一个选择器匹配的祖先元素，无论在 DOM 上有多少“跳”。

## [语法](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Child_combinator#语法)

```css
元素 1 > 元素 2 { 样式声明 }
```

## [示例](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Child_combinator#示例)

### [CSS](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Child_combinator#css)

```css
span {
  background-color: aqua;
}

div > span {
  background-color: yellow;
}
```

### [HTML](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Child_combinator#html)

```html
<div>
  <span>
    1 号 span，在 div 中。
    <span>2 号 span，在 div 中的 span 中。</span>
  </span>
</div>
<span>3 号 span，不在 div 中。</span>
```

# **后代组合器**

（通常用单个空格（" "）字符表示）组合了两个选择器，如果第二个选择器匹配的元素具有与第一个选择器匹配的祖先（父母，父母的父母，父母的父母的父母等）元素，则它们将被选择。利用后代组合器的选择器称为*后代选择器*。

```
/* List items that are descendants of the "my-things" list */
ul.my-things li {
  margin: 2em;
}
```

从技术上讲，后代组合器是两个选择器之间的一个或多个 [CSS](https://developer.mozilla.org/zh-CN/docs/Glossary/CSS) 空格字符——空格字符和/或四个控制字符之一：回车、换页、换行和制表符在没有其他组合器的情况下。此外，组成组合器的空白字符可以包含任意数量的 CSS 注释。

## [语法](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Descendant_combinator#语法)

```css
selector1 selector2 {
  /* property declarations */
}
```

## [Examples](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Descendant_combinator#examples)

### [CSS](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Descendant_combinator#css)

```css
li {
  list-style-type: disc;
}

li li {
  list-style-type: circle;
}
```

### [HTML](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Descendant_combinator#html)

```html
<ul>
  <li>
    <div>Item 1</div>
    <ul>
      <li>Subitem A</li>
      <li>Subitem B</li>
    </ul>
  </li>
  <li>
    <div>Item 2</div>
    <ul>
      <li>Subitem A</li>
      <li>Subitem B</li>
    </ul>
  </li>
</ul>
```

# 基础选择器

- [标签选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Type_selectors) `elementname`
- [类选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Class_selectors) `.classname`
- [ID 选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/ID_selectors) `#idname`
- [通配选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Universal_selectors) `* ns|* *|*`
- [属性选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Attribute_selectors) `[attr=value]`
- [状态选择器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Pseudo-classes) `a:active, a:visited`



# Value


CSS 中的值类型是一种定义了一些可使用的值的集合的方式。这意味着如果你看到的 `<color>` 是有效的，那么你就不需要考虑可以使用哪种类型——不管是关键字、十六进制值还是 `rgb()` 函数等都是有效的。如果浏览器支持这些可用的 `<color>` 值，则可以使用它们当中的任意一个。MDN 上针对每个值类型的页面将提供有关浏览器支持的信息。例如，如果你查看 [``](https://developer.mozilla.org/zh-CN/docs/Web/CSS/color_value) 的页面，你将看到浏览器兼容性部分列出了不同类型的颜色值以及对它们的支持。

让我们来看看你可能经常遇到的一些值和单位类型，并提供一些示例，以便你尝试使用各种值的可能性。

## [数字、长度和百分比](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units#数字、长度和百分比)

你可能会发现自己在 CSS 中使用了各种数值数据类型。以下全部归类为数值：

| 数值类型       | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| `<integer>`    | `<integer>` 是一个整数，比如 `1024` 或 `-55`。               |
| `<number>`     | `<number>` 表示一个小数——它可能有小数点后面的部分，也可能没有，例如 `0.255`、`128` 或 `-1.2`。 |
| `<dimension>`  | `<dimension>` 是一个 `<number>` 它有一个附加的单位，例如 `45deg`、`5s` 或 `10px`。`<dimension>` 是一个伞形类别，包括 `<length>`、`<angle>`、`<time>` 和 `<resolution>` 类型。 |
| `<percentage>` | `<percentage>` 表示一些其他值的一部分，例如 `50%`。百分比值总是相对于另一个量。例如，一个元素的长度相对于其父元素的长度。 |

### [长度](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units#长度)

最常见的数字类型是 [``](https://developer.mozilla.org/zh-CN/docs/Web/CSS/length)，例如 `10px`（像素）或 `30em`。CSS 中有两种类型的长度——相对长度和绝对长度。重要的是要知道它们之间的区别，以便理解他们控制的元素将变得有多大。

#### 绝对长度单位

以下都是**绝对**长度单位——它们与其他任何东西都没有关系，通常被认为总是相同的大小。

| 单位 | 名称         | 等价换算                 |
| :--- | :----------- | :----------------------- |
| `cm` | 厘米         | 1cm = 37.8px = 25.2/64in |
| `mm` | 毫米         | 1mm = 1/10th of 1cm      |
| `Q`  | 四分之一毫米 | 1Q = 1/40th of 1cm       |
| `in` | 英寸         | 1in = 2.54cm = 96px      |
| `pc` | 派卡         | 1pc = 1/6th of 1in       |
| `pt` | 点           | 1pt = 1/72th of 1in      |
| `px` | 像素         | 1px = 1/96th of 1in      |

这些值中的大多数在用于打印时比用于屏幕输出时更有用。例如，我们通常不会在屏幕上使用 `cm`（厘米）。惟一一个你经常使用的值，估计就是 `px`（像素）。

#### 相对长度单位

相对长度单位是相对于其他某些东西的。例如：

- `em` 和 `rem` 分别相对于父元素和根元素的字体大小。
- `vh` 和 `vw` 分别相对于视口的高度和宽度。

使用相对单位的好处是，通过一些精心的规划，你可以使文本或其他元素的大小相对于页面上的任何指定的东西进行缩放。要获取可用的相对单位的完整列表，请参阅 [``](https://developer.mozilla.org/zh-CN/docs/Web/CSS/length) 类型的参考页面。



# Boxes

某些 HTML 元素，如 `<h1>` 和 `<p>`，默认使用 `block` 作为外部显示类型。

某些 HTML 元素，如 `<a>`、 `<span>`、 `<em>` 以及 `<strong>`，默认使用 `inline` 作为外部显示类型

## box behavior

一个拥有 `block` 外部显示类型的盒子会表现出以下行为：

- 盒子会产生换行。
- [`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width) 和 [`height`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/height) 属性可以发挥作用。
- 内边距、外边距和边框会将其他元素从当前盒子周围“推开”。
- 如果未指定 [`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width)，方框将沿行向扩展，以填充其容器中的可用空间。在大多数情况下，盒子会变得与其容器一样宽，占据可用空间的 100%。

某些 HTML 元素，如 `<h1>` 和 `<p>`，默认使用 `block` 作为外部显示类型。

一个拥有 `inline` 外部显示类型的盒子会表现出以下行为：

- 盒子不会产生换行。
- [`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width) 和 [`height`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/height) 属性将不起作用。
- 垂直方向的内边距、外边距以及边框会被应用但是不会把其他处于 `inline` 状态的盒子推开。
- 水平方向的内边距、外边距以及边框会被应用且会把其他处于 `inline` 状态的盒子推开。

某些 HTML 元素，如 `<a>`、 `<span>`、 `<em>` 以及 `<strong>`，默认使用 `inline` 作为外部显示类型。





# Mock

这里的问题涉及到JavaScript变量的声明和作用域，下面是对每个语句的真假判断和解释：

![Uploaded image](https://files.oaiusercontent.com/file-3v8bcmwG9SnfKzEPitL0iAr3?se=2024-05-03T11%3A51%3A29Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D299%2C%20immutable&rscd=attachment%3B%20filename%3Dimage.png&sig=km4IGQsl1PzDE2ZaVizNG8cr%2BGyAgr9S6EzP7aKQ6nU%3D)

a) Variables with block scope are declared using the let keyword.

- **正确**。在JavaScript中，`let`关键字用于声明具有块级作用域的变量。块级作用域意味着变量仅在它被声明的代码块（例如for循环、if条件语句等）内有效。

b) The keyword const is used to declare variables that you should not change after they are assigned.

- **正确**。`const`关键字用于声明一个常量，一旦给常量赋值后，其值就不能被重新赋值。尝试修改`const`声明的变量的值将会导致运行时错误。

c) A variable declared outside a function definition using the let keyword is a global variable.

- **错误**。使用`let`关键字在函数外部声明的变量并不是全局变量，而是属于它所在的块级作用域。只有在顶层代码块（不在任何函数内）使用`let`声明变量时，它才是全局的。

d) A variable declared outside a function definition using the var keyword is a global variable.

- **正确**。使用`var`关键字在函数外部声明的变量是全局变量。这意味着它在整个应用中都是可访问的，除非它被声明在某个闭包内部。

这些问题涉及的是JavaScript中非常基本但重要的概念，理解这些可以帮助开发者更好地管理变量的作用域和生命周期。



![Uploaded image](https://files.oaiusercontent.com/file-J8F7WEe5laSPTLmKcJE5eSDn?se=2024-05-03T11%3A54%3A20Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D299%2C%20immutable&rscd=attachment%3B%20filename%3Dimage.png&sig=1/CiLBQPGM4AKKBpk2vR00f1Xh1R%2BVEZaI139DfXFZI%3D)

一个修正后的有效JSON对象示例如下：

```json
{
  "name": "David",
  "prizes_won": 3
}
```

![image-20240503125540439](C:\Users\Ricardo\AppData\Roaming\Typora\typora-user-images\image-20240503125540439.png)

在提供的JavaScript对象中，你的任务是检查该对象是否包含名为 `description` 的属性。对于选择的四个表达式，我们需要确定哪一个不能用来确定对象是否有这个属性：

1. **`if (flowers.description != undefined) { return true; }`**
   - 这个表达式检查 `description` 属性是否不是 `undefined`。如果该属性存在，并且其值不是 `undefined`，则返回 `true`。这种方式是有效的，因为它直接查询属性值。
2. **`flowers.hasOwnProperty("description")`**
   - 这个方法用来检查 `flowers` 对象自身是否有名为 `description` 的属性（不考虑原型链）。如果有，返回 `true`。这是一个正确且常用的方法来检测对象属性。
3. **`flowers.contains(description)`**
   - `contains` 方法通常用于检测数组是否包含某个元素，或者是判断DOM节点是否包含另一个节点，并不是一个标准的JavaScript对象方法来检查对象属性。因此，这个表达式是**无效的**，并且会导致错误，因为 `flowers` 对象并没有 `contains` 方法。
4. **`if ('description' in flowers) { return true; }`**
   - 使用 `in` 关键字来检查 `description` 属性是否在 `flowers` 对象中（包括原型链中的属性）。如果存在，返回 `true`。这是一个有效的方法来检查属性是否存在。

# JSON object

为了将上述示例转换为有效的JSON对象，我们需要根据JSON规范做出一些修改。JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，它易于人阅读和编写，同时也易于机器解析和生成。一个有效的JSON对象需要满足以下几个要求：

1. **键（Key）和字符串（String）值必须用双引号包围**。
2. **使用冒号`:`分隔键和值**。
3. **不需要为数值类型的值使用引号**。
4. **使用逗号`,`分隔不同的键值对**。

根据上述规则，我们来逐项判断所提供选项的正确与否：

- **[a] True（正确）**: 键“name”和“prizes_won”需要用双引号包围。
- **[b] True（正确）**: 字符串值"David"需要用双引号包围。
- **[c] False（错误）**: 数值3不需要用双引号包围，数值在JSON中直接表示即可。
- **[d] True（正确）**: 需要将等号`=`替换为冒号`:`来正确地分隔键和值。

一个修正后的有效JSON对象示例如下：

```json
{
  "name": "David",
  "prizes_won": 3
}
```



# Undergraduate Mock Past Paper

# CSS media quiry

最简单的媒体查询语法看起来是像这样的：

CSSCopy to Clipboard

```css
@media media-type and (media-feature-rule) {
  /* CSS rules go here */
}
```

它由以下部分组成：

- 一个媒体类型，告诉浏览器这段代码是用在什么类型的媒体上的（例如印刷品或者屏幕）；
- 一个媒体表达式，是一个被包含的 CSS 生效所需的规则或者测试；
- 一组 CSS 规则，会在测试通过且媒体类型正确的时候应用。

你可以指定的媒体类型为：

- `all`
- `print`
- `screen`
- `speech`

一个受到良好支持的媒体特征是`orientation`，我们可以用它测得竖放（portrait mode）和横放（landscape mode）模式。要在设备处于横向的时候改变 body 文本颜色的话，可使用下面的媒体查询。

```css
@media (orientation: landscape) {
  body {
    color: rebeccapurple;
  }
}
```

## 媒体查询中的“或”逻辑

如果你有一组查询，且要其中的任何一个都可以匹配的话，那么你可以使用逗号分开这些查询。在下面的示例中，文本会在视口至少为 400 像素宽的时候**或者**设备处于横放状态的时候变为蓝色。如果其中的任何一项成立，那么查询就匹配上了。

CSSCopy to Clipboard

```css
@media screen and (min-width: 400px), screen and (orientation: landscape) {
  body {
    color: blue;
  }
}
```

## Not逻辑

你可以用`not`操作符让整个媒体查询失效。这就直接反转了整个媒体查询的含义。因而在下面的例子中，文本只会在朝向为竖着的时候变成蓝色。

CSSCopy to Clipboard

```css
@media not all and (orientation: landscape) {
  body {
    color: blue;
  }
}
```

# JS-Hoisting

Hoisting是JavaScript中的一个概念，指的是在代码执行过程中，变量和函数的声明会被提升到当前作用域的顶部，无论它们在代码中的实际位置。

在JavaScript中，变量和函数可以在声明之前被使用。这是因为在代码执行之前，JavaScript引擎会对变量和函数的声明进行提升，但不会提升它们的赋值或定义。这意味着，无论在代码的哪个位置声明变量或函数，它们都会被移动到当前作用域的顶部，然后再执行代码。

例如，考虑以下代码：

```
javascriptCopy codeconsole.log(x); // undefined
var x = 5;
```

在这个例子中，尽管`console.log(x)`在变量`x`的声明之前，但由于JavaScript中存在变量提升，代码实际执行时相当于：

```
javascriptCopy codevar x;
console.log(x); // undefined
x = 5;
```

这就是变量提升的工作原理。值得注意的是，只有声明会被提升，赋值不会被提升。函数声明也会被提升，但是函数表达式不会被提升。

理解Hoisting对于编写可读性高且不容易出错的代码非常重要。