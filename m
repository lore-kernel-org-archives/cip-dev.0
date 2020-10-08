Return-Path: <SRS0=OEJK=DP=lists.cip-project.org=bounce+64572+5509+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D3C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 07:58:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D0621897
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="N+HcocSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D0621897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5509+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aSJpYY4521723x4aUHUNhWh6; Thu, 08 Oct 2020 00:58:47 -0700
X-Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.6993.1602143926575942754
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 00:58:47 -0700
X-Received: by mail-lj1-f174.google.com with SMTP id f21so4725215ljh.7
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 00:58:46 -0700 (PDT)
X-Gm-Message-State: XucVQYDKW0cLJZQhPJgWPacnx4520388AA=
X-Google-Smtp-Source: ABdhPJzdKekWFLcsT8XzxEN3Br0XQo00nCSvP/1B7TXhVjUxXMxZwbttSHMLDG+oqHJs4nNHqFDtsA==
X-Received: by 2002:a2e:b178:: with SMTP id a24mr2456062ljm.276.1602143924095;
        Thu, 08 Oct 2020 00:58:44 -0700 (PDT)
X-Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m20sm794066ljp.132.2020.10.08.00.58.43
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 00:58:43 -0700 (PDT)
X-Received: by mail-lf1-f41.google.com with SMTP id r127so5398326lff.12
        for <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2020 00:58:43 -0700 (PDT)
X-Received: by 2002:a19:c6c8:: with SMTP id w191mr1964464lff.348.1602143923493;
 Thu, 08 Oct 2020 00:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp> <20200925035927.1958987-2-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-2-daniel.sangorrin@toshiba.co.jp>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Oct 2020 15:58:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v66FnJK0YLUxdJZFd1NdA1f+sZXsgwku+JQt3atd35WkFA@mail.gmail.com>
Message-ID: <CAGb2v66FnJK0YLUxdJZFd1NdA1f+sZXsgwku+JQt3atd35WkFA@mail.gmail.com>
Subject: Re: [cip-dev] [cip-kernel-sec 1/3] report_affected: word-wrap for the 'description'
To: cip-dev@lists.cip-project.org
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="WC71JhcFKRKPa4m9FD4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602143927;
 bh=uuj367luU9m0TkcbGb1xO6pudXWyj0HwFxji/JzMzrA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=N+HcocScXMndYvUh/fuwbsu89cJB+hohHp6/A+XxS0xo01Xg0NLewWOC7myWEJ49pKk
 h2ti7rteOaXOydwAcDUwFKSSGnkpp+ZhyZA4lf/I2xWQaP8naTXwRC2kLcpau7CObvV30
 xhuhGxRGpFZTWUJbdpLvidQl1bOzkC4esi8=

--WC71JhcFKRKPa4m9FD4y
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020 at 12:00 PM Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>
> From: Nguyen Van Hieu <hieu2.nguyenvan@toshiba.co.jp>
>
> Currently some descriptions are quite long, and it is hard to read.
> Add line-breaks so every line is at most 80 characters long.
>
> Signed-off-by: Nguyen Van Hieu <hieu2.nguyenvan@toshiba.co.jp>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  scripts/report_affected.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/report_affected.py b/scripts/report_affected.py
> index a97b700..a181d97 100755
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
> @@ -19,6 +19,7 @@ import kernel_sec.branch
>  import kernel_sec.issue
>  import kernel_sec.version
>
> +import textwrap
>
>  def main(git_repo, remotes, only_fixed_upstream,
>           include_ignored, show_description, *branch_names):
> @@ -136,8 +137,11 @@ def main(git_repo, remotes, only_fixed_upstream,
>          if show_description:
>              print('%s:' % branch['full_name'])
>              for cve_id in sorted_cve_ids:
> -                print(cve_id, '=>',
> -                      kernel_sec.issue.load(cve_id).get('description', 'None'))
> +                description=kernel_sec.issue.load(cve_id).get('description', 'None')
> +                wrap_description = ''
> +                for line in textwrap.wrap(description, 80, break_long_words=False):
> +                    wrap_description += line + '\n  '

I believe it would be better to include the "CVE => " string in the full text
passed to textwrap. That would make all lines properly wrapped at the given
width.

Also, textwrap can handle indentation for subsequent lines, so you don't have
to handle that yourself. And it might be easier to read if they matched up
with the beginning of the description in the first line.

Last, you could use join() to combine the lines.

So I would rewrite the part as:

    text = cve_id + ' => ' +
kernel_sec.issue.load(cve_id).get('description', 'None')
    print('\n'.join(textwrap.wrap(text, 80, subsequent_indent=' ' *
(len(cve_id) + 4), break_long_words=False)))


ChenYu
Moxa


> +                print(cve_id, '=>',wrap_description)
>          else:
>              print('%s:' % branch['full_name'], *sorted_cve_ids)
>
> --
> 2.25.1
>
>
> 
>

--WC71JhcFKRKPa4m9FD4y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5509): https://lists.cip-project.org/g/cip-dev/message=
/5509
Mute This Topic: https://lists.cip-project.org/mt/77073066/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WC71JhcFKRKPa4m9FD4y--
