Return-Path: <SRS0=7Q8q=DP=lists.cip-project.org=bounce+64572+5510+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD253C43467
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:00:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D9D21924
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 08:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IZ1lBwan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D9D21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5510+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AvriYY4521723x4rfxlYTuUX; Thu, 08 Oct 2020 01:00:13 -0700
X-Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.7014.1602144012665164968
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 01:00:13 -0700
X-Received: by mail-lj1-f175.google.com with SMTP id a23so3940654ljp.5
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:00:12 -0700 (PDT)
X-Gm-Message-State: gr1iJvpCB1lbKlTovDAV4CWgx4520388AA=
X-Google-Smtp-Source: ABdhPJxmEb8QSSFnAgR5Mt2e2Mye+Edh6Pm0jgHW/d8qQGc/XLY0LdZxCHd0HJnDBHZ5vMYCXRCdbg==
X-Received: by 2002:a05:651c:484:: with SMTP id s4mr2822223ljc.391.1602144010613;
        Thu, 08 Oct 2020 01:00:10 -0700 (PDT)
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m19sm793900lji.112.2020.10.08.01.00.10
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 01:00:10 -0700 (PDT)
X-Received: by mail-lj1-f178.google.com with SMTP id i2so4745379ljg.4
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 01:00:10 -0700 (PDT)
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr2572329ljc.190.1602144009962;
 Thu, 08 Oct 2020 01:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp> <20200925035927.1958987-3-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-3-daniel.sangorrin@toshiba.co.jp>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Oct 2020 15:59:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v67PutE3wGTOnQMy3FSzWD9uUGth1PF6=wJNY0nRfrn-bg@mail.gmail.com>
Message-ID: <CAGb2v67PutE3wGTOnQMy3FSzWD9uUGth1PF6=wJNY0nRfrn-bg@mail.gmail.com>
Subject: Re: [cip-dev] [cip-kernel-sec 2/3] report_affected: Delete extra blank lines between CVEs
To: cip-dev@lists.cip-project.org
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6hfBpT9p4DrhmTsqLiZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602144013;
 bh=WjjVUUok6UOgBBO0JVLeAfNbTXUZJtiiCnyYtUOAZX0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IZ1lBwanKPMg+ZMwvXanNawQeFmfG12HZYdcPUm6UveY0kwrPBAoTk/G9iLDEnTK1J2
 OPcbUX9RPXYN3NEtekzWJsptefY+NtxpwdcZV5hZM5VLE7sXisY6noZ4nmjPQpLaN05NZ
 qrOIBFqHix+z5KVyN+0oojg77FAzxwh7VMk=

--6hfBpT9p4DrhmTsqLiZP
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020 at 12:00 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
>
> When using the --show-description option CVEs had blank
> lines between them. Remove them to make it more compact.
>
> Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

Reviewed-by: Chen-Yu Tsai (Moxa) <wens@csie.org>

Though these occurrences seem to be very rare.

> ---
>  scripts/report_affected.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/report_affected.py b/scripts/report_affected.py
> index a181d97..9894602 100755
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
> @@ -141,7 +141,7 @@ def main(git_repo, remotes, only_fixed_upstream,
>                  wrap_description = ''
>                  for line in textwrap.wrap(description, 80, break_long_words=False):
>                      wrap_description += line + '\n  '
> -                print(cve_id, '=>',wrap_description)
> +                print(cve_id, '=>',wrap_description.strip())
>          else:
>              print('%s:' % branch['full_name'], *sorted_cve_ids)
>
> --
> 2.25.1
>
>
> 
>

--6hfBpT9p4DrhmTsqLiZP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5510): https://lists.cip-project.org/g/cip-dev/message=
/5510
Mute This Topic: https://lists.cip-project.org/mt/77073065/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6hfBpT9p4DrhmTsqLiZP--
