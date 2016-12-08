From: don.brown@codethink.com (Don Brown)
Date: Thu, 08 Dec 2016 09:44:10 -0500
Subject: [cip-dev] The Problem with build.log
Message-ID: <01e40d42ba066478e3aa474b7b6fea5e@codethink.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Robert,

I may have found the problem with the links to the build.log,
kernel.config and zImage files.

As you can see from the attached Screenshots, when I hover over the
links, the URL has some duplicated information in it.

  * For instance, the link to the build.log file is shown as:
      o
/localhost:5000/build/cip-dreiwettertaft/kernel/v4.4.27/localhost/cip-dreiwettertaft/kernel/v4.4.27/arm-tinyconfig/build.log/
  * The kernel.config link is shown as:
      o
/localhost:5000/build/cip-dreiwettertaft/kernel/v4.4.27/localhost/cip-dreiwettertaft/kernel/v4.4.27/arm-tinyconfig/kernel.config/
  * The zImage link is shown as:
      o
/localhost:5000/build/cip-dreiwettertaft/kernel/v4.4.27/localhost/cip-dreiwettertaft/kernel/v4.4.27/arm-tinyconfig/zImage/

The files are actually stored in the following location on disk:

//var/www/images/kernel-ci/cip-dreiwettertaft/v4.4.27/arm-tinyconfig/

So I think they are grabbing a string to append to the site URL and they
are grabbing more than they wanted.

P.S. I also created an Issue (#2) in the GitLab site for this, but I
wasn't sure how attaching the pics would go.

-- 
Don Brown
Codethink, Ltd.
Software Engineering Consultant
Indianapolis, IN USA
Email: don.brown at codethink.co.uk
Mobile: +1 317-560-0513
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20161208/34a8a26f/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot #1 from 2016-12-07 19-50-36.png
Type: image/png
Size: 120710 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20161208/34a8a26f/attachment-0003.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot #2 from 2016-12-07 19-50-57.png
Type: image/png
Size: 115470 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20161208/34a8a26f/attachment-0004.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Screenshot #3 from 2016-12-07 19-51-08.png
Type: image/png
Size: 120762 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20161208/34a8a26f/attachment-0005.png>
