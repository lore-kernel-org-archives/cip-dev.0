Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17598C61DBD
	for <webhook@archiver.kernel.org>; Sat, 21 Feb 2026 05:22:14 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15026.1771651331589536897
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Feb 2026 21:22:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L+rYRXj8;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069ad750b7so23182541cf.2
        for <cip-dev@lists.cip-project.org>; Fri, 20 Feb 2026 21:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771651330; cv=none;
        d=google.com; s=arc-20240605;
        b=RR6875XAk3jCC3JztU6nkXU+f8RkdFTjAklJMVZzmXyy1NMF4FyIbVdK/OOR24BTXn
         /0YCS9L3rwSaBmlIko8gV5Poe4ONY1N1FGpvAekWHAsdvNbIQSP7iihv2AdSp0CYBFFM
         GXpVXlwxgLUTLxJjA1bVsWxt4lo2VppyyV/fh8pPRcmZ7nmUlgh6G9oCj7ApB5oSPMDl
         EGMmqPrbW7SAsawgd194YzVotRDQ7n7R7PwBJC/3IswLQkO+zcnXPEqjluWS1veQ/dfO
         lXG/DmFC86ZXHo3pTXMF/l1xNrDXvnFzInZxTv0dnzNoRAY4WNKjVEv30e8qZbteatnA
         85EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pA0JIjrDwZUFcDWQQDo7x0Isbts3QtOvU5KTi3dMjAQ=;
        fh=t2lfLlfZyxM7MAzS9bme+Si9BbeedF+2Vm/Hk+tg7E4=;
        b=fa6x6gn0cKuUaKp+9JjSbiJ3qO7uE3pP2JaROWF47vgwwXhCbgSLlw5gtQdJ6GGD+K
         riPoiZM07g2HRNbYWYjCRredBuVnCbi+WjDakzwI9aPJ7UKZh42kTLwRdkmH16gkV4d/
         p43Qld/tsUUrKECCB68aotahkGv9r1W+m6aljaxql8YvguS+zrFZJhChf/2yfyC056te
         Cf4OL59ZWK3hcsR5nlAE2ixVOVE4xzLjzJIQUBQyaw4fMFjIEZcBlwK7reVqBZW0yXAp
         9yKLog23pzEMujfoGWAhYR097Sf9la0BEtTtjjiok5JPF7q4hQkD3pOJQit5yO8UZTj8
         6ZHw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771651330; x=1772256130; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA0JIjrDwZUFcDWQQDo7x0Isbts3QtOvU5KTi3dMjAQ=;
        b=L+rYRXj82bcy3lkZ7EyPzRt7QF4YFJhgqdk9FB4s3SEmJcpR7YI4uNsH27PqkTrO7+
         RRK/Va5+jk3m6UQ65xoOx+v+GGL/BTI4fxlK9tE5Cinz9Ad6hZAbJ38BVT99+aFndHRk
         cjMXnPq6u4I7W16DWTCgramLRiyo3rfV8Ar5jqcg8/W4ddJvEUHEkIVRW+TS2y7geeGb
         5fHa7ePlBFnRkOn4VUJSfgI2A7Q+zS4RUspp8eUKOqBmRJbKcNGiHLc6Nbgka4GijZi3
         8DeNfuwPT7CmrvOxwRJdmK/HaFreXTfmApeH0s47ndcIWm4yYwKpVjfhql2RZYzIbbnx
         pGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771651330; x=1772256130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pA0JIjrDwZUFcDWQQDo7x0Isbts3QtOvU5KTi3dMjAQ=;
        b=FJZINYV4SYl4ZqdOvoNUoEnhmd2DI/rXVbvsuDQMp1QMkKoX/BFoyn0LEQ8nZowC7c
         4opqWd7NX0LiIiBMR6VwyiBjICfL0IgUWmXrldXdsmc20hbS2GxM8/QeU4e8wIiWs/dN
         qByvASgFN1r9cuceWQPBF7NdFSKRWjcln1ePTl9pNzfboWPbS3tI5ASnMX+V+xevq6YQ
         0qMGOhNcIbiTVxgi0+vi6uGLjfikZr8ZwLshqlUqz1FMjCfqm7+DOzQHAdX5eRVcsY04
         LxBJLKm89coDHzc57CqBiNJnto5pMjKlv2jrKQFDGIheQznsz7HzQ4lxT3Ky36ly7R+Q
         7yuw==
X-Gm-Message-State: AOJu0YwwH/5TnRO9iiLS8EUESVkQI6MX9oyh4ia4rWKAtPiKDww72mQk
	eZrhZ5I57PxSHsR7MXr0gK6vNMrCdnVyaGJc4ZXvvZrbHFl051geF9eINGJ3lV4Nj8/pJtNF8iz
	xZ2c2X2HVWu+BQ5UUdEnmLm847a3Q/Nc=
X-Gm-Gg: AZuq6aJM0AShu8jMbxuQIXXH7A03QFuUAMD37bdXmXOaccWmxlhKmxGEIW8GKo6UV8f
	ikmxTh1tr86OxsDnrrmOd6U6LRcPYLd7T4t0s5PNbJS2685BLoKEspeHrdGSlmRXovJ4/nSaobG
	iVGn9T/xSwcSudQDoxkU4B8ZWOt8Q85sFEzRyELDWaOxg0dYNv4EAI21bO3fLpGJK9Zps9pyKCF
	VMRYizNXyWHnIX46e8MkeoqFPEtw5OFXu5cBQU1sut3g/cydWMZTxeUp22OF+eBqRTkfYJWhnqN
	jPXR
X-Received: by 2002:a05:622a:102:b0:502:e1ed:c352 with SMTP id
 d75a77b69052e-5070bc6b51emr30289361cf.45.1771651330499; Fri, 20 Feb 2026
 21:22:10 -0800 (PST)
MIME-Version: 1.0
References: <1504945381.404757.1771569526446@webmail.strato.de>
In-Reply-To: <1504945381.404757.1771569526446@webmail.strato.de>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 21 Feb 2026 14:21:59 +0900
X-Gm-Features: AaiRm52iOeLpew_Mpr7JaCWuNx36WaVRqn7DVy-VFYEGPoPI_zsGh5kyWyPBytY
Message-ID: <CACe6DC6Lt0Y9vPfMb9NhgOg4FcMCWDaFxAR7c8oLh9rZt87SPA@mail.gmail.com>
Subject: Re: [cip-dev] Request for review for 4.19-st13, 4.19-cip129
To: uli@fpond.eu
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, 
	"pavel@nabladev.com" <pavel@nabladev.com>, 
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Feb 2026 05:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21904

Hi Uli,

The following commit requires a fix. Enabling the driver will cause a
build error.

c85bc75effc21 fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe(=
)
```
drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_probe':
drivers/video/fbdev/ssd1307fb.c:726:22: error: passing argument 1 of
'__free_pages' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  726 |         __free_pages(vmem, get_order(vmem_size));
      |                      ^~~~
      |                      |
      |                      u8 * {aka unsigned char *}
In file included from ./include/linux/idr.h:16,
                 from ./include/linux/kernfs.h:14,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from ./include/linux/backlight.h:12,
                 from drivers/video/fbdev/ssd1307fb.c:9:
./include/linux/gfp.h:566:39: note: expected 'struct page *' but
argument is of type 'u8 *' {aka 'unsigned char *'}     566 | extern
void __free_pages(struct page *page, unsigned int order);
      |                          ~~~~~~~~~~~~~^~~~
```

This can be fixed by cast to vmem.
```
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 8217910980487..20e83145fbacf 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -723,7 +723,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 reset_oled_error:
        fb_deferred_io_cleanup(info);
 fb_defio_error:
-       __free_pages(vmem, get_order(vmem_size));
+       __free_pages((void *)vmem, get_order(vmem_size));
 fb_alloc_error:
        framebuffer_release(info);
        return ret;
```

Best regards,
  Nobuhiro

2026=E5=B9=B42=E6=9C=8820=E6=97=A5(=E9=87=91) 15:39 Ulrich Hecht via lists.=
cip-project.org
<uli=3Dfpond.eu@lists.cip-project.org>:

>
> Hi!
>
> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>
> 797ce10e2a2f1 macvlan: fix possible UAF in macvlan_forward_source()
> 85f1f9ce40bf7 HID: uclogic: Correct devm device reference for hidinput in=
put_dev name
> 0c110bc67bd3d xfs: set max_agbno to allow sparse alloc of last full inode=
 chunk
> 6a8957a06bc31 l2tp: avoid one data-race in l2tp_tunnel_del_work()
>
> Thanks for having a look!
>
> CU
> Uli
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21902): https://lists.cip-project.org/g/cip-dev/messa=
ge/21902
> Mute This Topic: https://lists.cip-project.org/mt/117906404/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--
Nobuhiro Iwamatsu

