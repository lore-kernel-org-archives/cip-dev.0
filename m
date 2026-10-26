Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40221.1793011373773857599
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 03:42:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fSnc74Ob;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1755976f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793011372; x=1793616172; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DyJl79Yd/1Jr33PONsC05GNKebQFW4L9cj4q6/oIr0=;
        b=fSnc74ObXGI9+NvJFRz1ngx2BUU6GknwV15lz2XUIs2a6gPxAPBszKkFJjyPdOArb5
         e7j0vEq4BXoNdHOcbzOWgAaGDwTxL5eCP0E7qv4Q2XQiYYWO87tg7FwOIHDOpdBsGf0o
         0MyDn7sAqp3u978UE5HTgTk3nrM5z4dPNoQPfVicqY2WAETv2k7fBeUnxdJZjS7vCCQJ
         ntbTNWJETtfESpJYJ6vBhM+WsHb0YZqsKVy4kyh0+XV92xtNaGm5Qq1KqaJmZXiHkRCf
         fAoYRoUah724XokQsghvxQCiEtSAherN4qoeZioEGnmx+SIPG2TrVfbaWRWmxBZU/JyQ
         wbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011372; x=1793616172;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DyJl79Yd/1Jr33PONsC05GNKebQFW4L9cj4q6/oIr0=;
        b=n+IFc8LdcsT96e3N5sFTMdFOwKcFP0TL3CqRbBayeThenXwU5WISZp1k1WDvp0s5Fm
         69g645FpPN/uF+5UUdlyEdg9DD3aie2V+ZtmgIAm7LxDJjcpT1MAGPDg77C5coRCusqY
         KDMo0abJM6zAUDn6d4iqWGTDzjaJZK3XKIGE321w/jYCrBIlv8qYsgY/v1Wge9Vr/esk
         FxuzTNWO4eclmwXHK/6sJ1Iq7vkO9L5Hz0voPqwErPOqfMB8WUUnImSY0yTJVXuVv6qy
         YcYWm5nj+zv3UrrjIGb0LfoEifuzKDfcwnMimKZ3RhcJIJxLKzZ2mE1vb2+ljoGN3uCg
         LTyw==
X-Forwarded-Encrypted: i=1; AKwUvBwNciENGwNNOWaAnjJ5Xz27BEhL67OV312euCYfJ6dCWAMGJ9P4tXFbixZtNBSvQv89l7Osij6K@lists.cip-project.org
X-Gm-Message-State: AFq9FYI+aC+/9QOV/3EKOgEiv3HmoKQ4TTbYIoCpLsvMrrupA5G8m9Oj
	5gLj41g3K2URgDZOI9r2wqXfe/l8H948qfPDPhPx9ShkUgT+tht3lJhwVOYIe4MuYHQ=
X-Gm-Gg: AYBFou3iWQfZBAj0r3qiCyGtyq/ITGcd+zv0MobSSiH4bEdbKp3kCCdhxy3NTx51za/
	kCMG5mKwmXmRauk5vThigmhNpzlBoDR2JPt1qhQwPici49HcfIdABFw6MNzIO6n7RDWfVg2ql8C
	VdueTEQrSzVx5dNrkQMm3utxczubW/shz8NtOZXN4DnXyh2/ti5Qy+6szPf12l7TVEX+nyAFFSI
	MmO8o+y49XXNXx1GH6vmoTjLiO0/LqLKZRvrGxsclnZdu71szMRbnZ2w28vG2ahTax2rIUa3MxU
	pHqHYeAKdrxcVNitvBi7fKjPjdX0HzHmEeDQsISdBDIlm0UdaNWAJExkzRnu+Ygcb6cDsxqtKxn
	WHpl5UEFfW1zY37kaa/PKUOySx6X9B/wEebSGwrnPYLmqadXU7SIFuXw7ymQ/Om97nZAYnTCjD0
	OfNxkYV83JrgUwKcf+PjB7Dnz4SQWJW87emv+FGjHQpfTeTVJSmUEfPnPeYAPb6s5bAkuqJvHnB
	IsTBKfx7CPxwtK+WB9Pfa+YFstakRtBgS030PpLbeWuJYiwcveI1zpxrW+D/zorNT6wveYIsnM/
	y9ycNBW2KQ==
X-Received: by 2002:adf:ed8f:0:b0:48e:1d87:f170 with SMTP id ffacd0b85a97d-48e3eb83fffmr8217769f8f.12.1793011371965;
        Mon, 26 Oct 2026 03:42:51 -0700 (PDT)
Return-Path: <claudiu.beznea@tuxon.dev>
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm14578478f8f.3.2026.10.26.03.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:42:50 -0700 (PDT)
Message-ID: <a6b693a4-92e3-4864-954c-59a8b45d7b82@tuxon.dev>
Date: Mon, 26 Oct 2026 12:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 2/2] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
 claudiu.beznea.uj@bp.renesas.com
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979286-32200-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1792979286-32200-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 10:43:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24540



On 10/26/26 03:48, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> 
> commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
> 
> When stress-testing the system by repeatedly unbinding and binding the ADC
> device in a loop, and the ADC is a supplier for another device (e.g., a
> thermal hardware block that reads temperature through the ADC), it may
> happen that the ADC device is runtime-resumed immediately after runtime PM
> is enabled, triggered by its consumer. At this point, since drvdata is not
> yet set and the driver's runtime PM callbacks rely on it, a crash can
> occur. To avoid this, set drvdata just after it was allocated.
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> Link:https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com
> Cc:<Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
