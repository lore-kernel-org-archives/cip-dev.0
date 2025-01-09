Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE0E77199
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 12:37:28 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.46913.1736426238757174320
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 04:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B6f/NyK+;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29ff039dab2so409975fac.3
        for <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 04:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736426238; x=1737031038; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8e1TpeXABOW1RJQ3St4h7wzaiZ5QusUpez7igt4t8x0=;
        b=B6f/NyK+pTobtp+eKWvv6UDezaCHNjEo8n0tIL78z4FaXVECjYH01xSr17KTb0++Pf
         ZfDelcDtbws1t/MQTaqKyLr4Au2Xof+qesHdnBk6v6b61N9CdSKvP40QYKOjMzu2kIYV
         ooEOqA+V+DGegjgZImND76o4xeHTgQEcI/RaWnZlz5TnLN73kgxZp6++en2hSFh7q8n1
         Pz8LTaEAdjXW8UJFaAY4IzkP6ABApWcMVggNhLgdNyprj712gbhKjoAb9hTfqksRmdFy
         K32eNYHZwOCnUU9WtM2ARBhDjzOiZMQphkxn6bXiVXTnrB5aljkaiwv7u25Ng8JM9/Zb
         Za1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736426238; x=1737031038;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8e1TpeXABOW1RJQ3St4h7wzaiZ5QusUpez7igt4t8x0=;
        b=eefPGFxTbyfu7WXk5/AKqgIumiWGbyUj2kc+Us5b02vLFOtsTiuzKmhzc7jA3+nHfn
         qxqDVvvGgiIgJzul+Vf+Hjp/g5xBV6pqkbFrvGQOR6FcUIIblT/D2fcAt0wk7C5x6tLB
         MTymTcCrS6oPVy/FABa5Q50KbyJpv6MdTFPCxkPeRxmi4KoeC04+eXaX18WABw0PDS4c
         1ZfiCbGyTwhzutz1QhtIh+CPHSgeUcVvOcF3hBjXwbQTxXcliCoikLO9vxBjo8KAlTh6
         3x8HwVGFYykZQB3vVWLs3CYyCwV+H2r42NsULIWhQcVFKnZuSmtaVJkS5k37Pi1Hpctr
         cJyw==
X-Gm-Message-State: AOJu0Yzb83DuDInXFhb/Ngsxdinfw7MMgn5dGWdXv7D6buckUVty2jMJ
	U6G3NW/Hy948QdJLpRnFbXnv+N9sOsGFaXvrh5jis3PJgnz+YzaquO4tQTYYlLdJDqWViRL1zzq
	66JqIk/8oyB4z2S3ecZwD2mw6wnC1Uw==
X-Gm-Gg: ASbGncv6I7PklZayB410nhDfDpcwtRNMnWucQkubumAhwk9z7W047u5iuKOOEmD5Ri3
	6Z5LFBylXV897Y2emXoRn9KKOITZPq/hNDWf4
X-Google-Smtp-Source: AGHT+IEML7d94l8rmxAO5Ev9perfBCoN9YFppCy8/kNtxfPzbfY6ZId/kUDM2Iyf0bsK2P60G58k580cmp3Ec+D1Zi8=
X-Received: by 2002:a05:6870:af83:b0:29e:37bb:c0e0 with SMTP id
 586e51a60fabf-2aa06750143mr3508609fac.23.1736426237545; Thu, 09 Jan 2025
 04:37:17 -0800 (PST)
MIME-Version: 1.0
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Thu, 9 Jan 2025 06:37:04 -0600
X-Gm-Features: AbW1kvbDyTuNiY1MxDoUBj27R3vNaYJz8CuGjhT5Gz8pASBZo6Ib8iIXAoAEpb4
Message-ID: <CAK9C7GBuqQsWQahLo1pkpmSRGUr-Xi9ncPF6=ZNgkWOBZBaKNQ@mail.gmail.com>
Subject: btrfs support in initramfs-crypt-hook
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000001151d7062b453dad"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 12:37:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17513

--0000000000001151d7062b453dad
Content-Type: text/plain; charset="UTF-8"

Is the reason for lack of support here due to not having a package for
btrfs-progs-static, or was there some other reason?

I made my own recipe for building the btrfs-progs-static package.  Would
this be worth submitting a PR to add this support?

Thanks,
   Stephen

--0000000000001151d7062b453dad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Is the reason for lack of support here due to not having =
a package for btrfs-progs-static, or was there some other reason?<div dir=
=3D"auto"><br></div><div dir=3D"auto">I made my own recipe for building the=
 btrfs-progs-static package.=C2=A0 Would this be worth submitting a PR to a=
dd this support?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,=
</div><div dir=3D"auto">=C2=A0 =C2=A0Stephen</div></div>

--0000000000001151d7062b453dad--

