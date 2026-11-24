Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16102.1795520091176315744
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:34:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aDT4G0AF;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so41687865e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795520089; x=1796124889; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEU8iwFO9mv+6lp9d4IY+CIediW/oZUUeJGsHormk3s=;
        b=aDT4G0AFLpZpm8IhXihLcQmbThz97tlG4p9bQCP0hhyMmbMVotFDdC/cz2R+I1vF7w
         lk10qcrep/eswxZ5HQIYIMePT0r6iS2N7jXzl5iWjx8dXSZFqWKP4p1AW+xHTN3e1djU
         OtLDlEYJSxwgIPH7eK7vLWE+Xt0AU/KIiEeBRVRYkl8orPDkAOqhKdh2YtwKcgt2FRDp
         zFzloFrrZAvwalBqI6thMIEXaiCzKeFhVsjXe4N4XFOtuLssV/95mahK1CZ5YkiMEZ6t
         sJtg+8TtCjjVVnLX9yXr2F4yX6sUUHyUfcjLf9TxAmEdJD1wHeM/R40FtqbtqySJqbRv
         Ho8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520089; x=1796124889;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEU8iwFO9mv+6lp9d4IY+CIediW/oZUUeJGsHormk3s=;
        b=OMTIzYXyPuSqpZaxpPD7h8y/OUIwxoLr5H+PVNtJf+S7+/XmoQABRSJhqb6BIp4LCu
         KTzJfNteB44uUYuCpyAG+ifsv7a5DBEyBDMVWdSeaGHtO+UIN3RtGIzzU1uPkWQnAZEr
         mZcycWLsazYLioNgTTXaW5hbgUO9+sLathhUSBznhv9eDx1A8s2OwgCxGUBSYQidIyyO
         TSvqSgm9C3WH1mlGYzKmqoyOZ5leJbSuIx68KyUkuWLGyG/X/jh+XZJRHCJM5RnJdRHf
         l2ZTpydkcF+WyzF9WTUQVM1Z35y7QSIK9o34XZW3kRWZXoZ9PaLsWmK0hhuClQP78DOZ
         JJsA==
X-Forwarded-Encrypted: i=1; AL+hErG87QR0KuzYcFe5FbRDk1/WPQFYCimM8OQi/mmBs35OcN5eROU9TjpqDoiNE1t7DtAY6CFp0fci@lists.cip-project.org
X-Gm-Message-State: APuU4Z+0Gym/apsfVQvl6K9MpcwQk8HxJiNrORaJpiOyVHgsUqIZnWZ4
	i+e61qN1T85K5f+rkRsx2xWgdOqnsPf+9TLQSFEs7vK/i18by82eSZKFngUa/yh4lYk=
X-Gm-Gg: AZFdTZdNUMj9DO/FbmMiBYQwnVm6yBDA20U7jL+i0F+oFzu7t2jHSDotAfucc5xUeZZ
	MMZWZ1jb/14GEbqj3z4ZpOT/Ha9e4KFu8AIU6/d+07NDCKRlwlcarXx/KXiO10FpBlkxQytSvg9
	uGKLlaLKKAUYPUP+Id7sUXy2k03hVTzeHTnYWlkZmPpOoC3k8WUrb9DSy/xg822mRK8s9ZkiUVw
	roGkQBcuFe9fd+QegA+cIsI9ymHdnqoB5r0tZOyfPMjFBv3LqHs7fFT8LX1aHUKyTZ4WF9Brx3l
	Vny875WLXypMSlq7Uj+akdXXycqBRYxcMiD48BKGZJDodXaHa24aPEGtFBB7uvTTSKDJBfRSPH3
	9D9SshymWYNSsF67o5LLp1OJqNDUREJFjeLzPs7r3zjZKHD1lRFjDuE5DUpax6/pgEi6wnCclRz
	pxJpf8SFkgBI8kKRdcF3Ow/MZ38GxAA1fpVgXOXFPbitaWIExUfMw5vqY76CVCzNu7swawebbMz
	hjWBK5pUotr7/IMweQ3IvZiEtptbmlPRvG7aIvnCmBqKosMwCXF9DbD/mCI2WXWNBS4RbEfiqGS
	y2T2191IQ3VXZYELbyE4jJTr5KFt9KKSt68bEw==
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr289351445e9.10.1795520089033;
        Tue, 24 Nov 2026 03:34:49 -0800 (PST)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm27062555f8f.10.2026.11.24.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 03:34:48 -0800 (PST)
Message-ID: <732ba6e4-f3e1-42d9-9f00-5c42e1471a6e@tuxon.dev>
Date: Tue, 24 Nov 2026 13:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas
 RZ/G3S
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
 <awStSzX0cNPoVR5E@duo.ucw.cz>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <awStSzX0cNPoVR5E@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25061

Hi, Pavel,

On 11/23/26 23:16, Pavel Machek wrote:
> Hi!
> 
>> Series backports the I3C support for the Renesas RZ/G3S.
>>
>> Please provide your feedback.
> 
> I'd be happier if series were closer to 20 patches than 35 or
> 70... 

For future patch submission: would you prefer submitting individual series to 
enable a feature? E.g. for this series, instead of a single 34 patch series, 
would it have been easier for you if I had submitted it as 3 separate series, as 
follows:

- one series containing I3C patches (21 patches)
- one series containing pinctrl and clock patches (8 patches)
- one series containing device tree patches (5 patches)

?

Also, would you prefer to submit them at the same time or submit one series, 
wait for it to be integrated then go with the next series?

Thank you,
Claudiu
