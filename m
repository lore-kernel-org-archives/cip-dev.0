Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EFC64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 14:43:56 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.24020.1677852637095635536
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 06:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=EQwjVXHE;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: error27@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id d30so10880558eda.4
        for <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677852635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/KxR2Yk36cGi+1hPPW2sF/orIPGx6NVh5r4kIt2g8g=;
        b=EQwjVXHEu/SfPbAdCTSVGVly0LG2lZ1wa33HIdPLPL1sZXtkAF5NzdfVSHo09o0Wpz
         0f0XDvCjq6dZT11dObEm++Y4KtW80fP/AWSD6dxLi5nvVpS+q7qdJq83xIvLWwowmHDX
         aSi800VmjhDQkwboakdCS/JkHz0/5ar3bUHWwS6dAxPhNUleMcYZnVORkeTDB6jaxuOJ
         1YANQcUIbwPfAedTvc5gZxaJeHilgcQCmV7em2FqPWvD6+1TIAE298YPt3LUHhrpnbr1
         wIZLdjIPqc1DKl+avLGImwNzv523K/Pq1WQ0Qu5j+kNS1VUgeWEdQpwozlwalRmj2y+j
         /q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/KxR2Yk36cGi+1hPPW2sF/orIPGx6NVh5r4kIt2g8g=;
        b=Gy/OepzaTdOSgNOZLdndwLioyz9EWBrtnQuDnWOefd96qe5t+Syfd65V50iMbN+bCD
         RL/+43zrZzEP7NXYg3CPH59gfpkSfmsVp1K2UINa7uReUUqe/JhpjRzqn3Bf2cu6+E7V
         OGMAAmIChz2taDc/zy8bjhRfUuq0kjtH5VJHCkX955S2kwD/KxIKRwH1LFs+pz8psk3D
         L+Gb1E/ONuMklWz5YOG3yQc0SQwnsZ/M7nUGJhxwcKGlYwOP0LbOwxGxIWWygD+YzgcU
         neJAwb474KRKDY4vMq03jIG8G2brWp50fGUUW38x3yr8u2XeF6xeiSOtn5i8shjWiPix
         Iw9A==
X-Gm-Message-State: AO0yUKUvhlGYhiCKs2aCvVxNdLf4dseO51lRikX4yRLOHDKmy4TnwE5q
	kpXANHxx/XYGKTvoOntndvE=
X-Google-Smtp-Source: AK7set/rYorzupxGPn4yc2zauJX9etXI7yTThisf4uelhKGHrXQpzny3WZdbcZRmdIjuDBLHjdVvGQ==
X-Received: by 2002:a17:907:c60c:b0:7c0:e30a:d3e5 with SMTP id ud12-20020a170907c60c00b007c0e30ad3e5mr2271186ejc.18.1677852635573;
        Fri, 03 Mar 2023 06:10:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id kq17-20020a170906abd100b008e82cb55195sm974662ejb.203.2023.03.03.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:10:35 -0800 (PST)
Date: Fri, 3 Mar 2023 17:10:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: namjae.jeon@samsung.com
Cc: linux-cifs@vger.kernel.org, cip-dev <cip-dev@lists.cip-project.org>
Subject: [bug report] cifsd: add file operations
Message-ID: <120ff7ec-edea-471b-8ef0-362993a75f6a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 14:43:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10914

Hello Namjae Jeon,

The patch f44158485826: "cifsd: add file operations" from Mar 16,
2021, leads to the following Smatch static checker warning:

fs/ksmbd/vfs.c:1040 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'length'
fs/ksmbd/vfs.c:1041 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'start'

fs/ksmbd/vfs.c
    1021 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
    1022                          struct file_allocated_range_buffer *ranges,
    1023                          unsigned int in_count, unsigned int *out_count)
    1024 {
    1025         struct file *f = fp->filp;
    1026         struct inode *inode = file_inode(fp->filp);
    1027         loff_t maxbytes = (u64)inode->i_sb->s_maxbytes, end;
    1028         loff_t extent_start, extent_end;
    1029         int ret = 0;
    1030 
    1031         if (start > maxbytes)
                     ^^^^^^^^^^^^^^^^
loff_t is signed long long.  This comes from the user via
fsctl_query_allocated_ranges().  Both start and length can be negative.
So we can end up search through negative offsets.  Possibly
vfs_llseek() protects us.

    1032                 return -EFBIG;
    1033 
    1034         if (!in_count)
    1035                 return 0;
    1036 
    1037         /*
    1038          * Shrink request scope to what the fs can actually handle.
    1039          */
--> 1040         if (length > maxbytes || (maxbytes - length) < start)
    1041                 length = maxbytes - start;
    1042 
    1043         if (start + length > inode->i_size)
    1044                 length = inode->i_size - start;
    1045 
    1046         *out_count = 0;
    1047         end = start + length;
    1048         while (start < end && *out_count < in_count) {
    1049                 extent_start = vfs_llseek(f, start, SEEK_DATA);
    1050                 if (extent_start < 0) {
    1051                         if (extent_start != -ENXIO)
    1052                                 ret = (int)extent_start;
    1053                         break;
    1054                 }
    1055 
    1056                 if (extent_start >= end)
    1057                         break;
    1058 
    1059                 extent_end = vfs_llseek(f, extent_start, SEEK_HOLE);
    1060                 if (extent_end < 0) {
    1061                         if (extent_end != -ENXIO)
    1062                                 ret = (int)extent_end;
    1063                         break;
    1064                 } else if (extent_start >= extent_end) {
    1065                         break;
    1066                 }
    1067 
    1068                 ranges[*out_count].file_offset = cpu_to_le64(extent_start);
    1069                 ranges[(*out_count)++].length =
    1070                         cpu_to_le64(min(extent_end, end) - extent_start);
    1071 
    1072                 start = extent_end;
    1073         }
    1074 
    1075         return ret;
    1076 }

regards,
dan carpenter

