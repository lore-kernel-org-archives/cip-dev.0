Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9169.1794995025929819462
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 01:43:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=JfYAUVJt;
 spf=pass (domain: fairphone.com, ip: 209.85.218.46, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5067a2411bso95711966b.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 01:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794995024; x=1795599824; darn=lists.cip-project.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DZBhZ2+D1kgdYbte7a6QuhBIhLtQ7q/T7nzZcHZtAmM=;
        b=JfYAUVJtPDwzHAhayxeoTJRtwG5TgJdhXp6isdIe4hqneET5iK9Od8rZloYATg6+8+
         4kfT1t6NnLCWLRnG7pyC8QtOCgkfeIxZOlGSbO+aQz7NTk3qxfQ7/LD1j9ufcwJCZHLb
         yLk9QdGkF1zznl399TfulNptwwPTsYh3jcb6zVxhaEr7m7j4+1722XHsrJ+l6Zqo+5t1
         xVQp7jZ1nWqZIr9cIHl98czafXbUayTcN+xB359ZoVc+P7pJtARc8x1DbctuxITyzcln
         I504eUa+SYNqBf4lBUQ7IrKn22UEJpUDmGdugpAUnJGzgn0fgDRDVwn65XOGoeFZ++pR
         dUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995024; x=1795599824;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZBhZ2+D1kgdYbte7a6QuhBIhLtQ7q/T7nzZcHZtAmM=;
        b=IVEdwHOf5M3RIGvPMvoVfTMLnTeko0mkclraoZL0pXIslm4hwVfFAwqHehuOxHR2kv
         hPZHrtBXXhYxU0UBfxeh9lpA09FJJd17gxUyw/suy7W3hzzx/SykP/P6+jRRg1jRfMq7
         6b5Ab3t85WD6EQ1NPqUIGcQH5xw+lzBnXO34VvQPXupFfXZVbrj/qh3ce1v/LXv3pqlY
         eBzbZ7wIbGF3m1Xk10m9+gZ+j9HNlphBG8fWgaaZAiFuXqyoVzXpHHg/BY9GHlUT6fbd
         OBGRwIeNKtoUG1TWdIuejMFTfwU3lVijoMIJS6H2JHztzKGksQNx8xG7v4ccz6g9CV6E
         LFJg==
X-Gm-Message-State: APuU4Z80Diyccrno2gj0yLsHR7y0pYx6yyx9lA9zDgXZdIJNkOsO0gnx
	fyPdy43Ncg56/Qld7JEV55CDjLE6dHa652AB5eQ1hZ/jB9DHEb97jhnd41uxcXfXhOaCCqLqMUX
	wgfsFMMk7VQ==
X-Gm-Gg: AYBFou2jVB7a1i94ra9qbfujSGzrWVxxtFrz0/dANfiLf1xma4eyzCQPRRBi5XTI6N9
	b4KNqKcvxgi84EsbuXiTqFDQIFYDGme4GOouw9rYy0R4mruXf4zccRl7djGKerSGj783CRPTFL7
	06TjhCIDSHU+PFWcCcIL/nYtPHhjPF4EbZ919LC/GECiLQ3HKgC+i7FjHMSgsR4ABiyrqPgbuyY
	JmcZksCLhMO56nHyIIpeVqHZCFAObP9qtVDdJN9Ud8zcZzcHBtF8w+a/kwQOhpNw42Htwm/JACV
	Vw6TML0ka1HR8nah3OYkwNR5CulaABh3Hf0iDFrpa6D6x+k9e+KNydLEsLfv0bwDZ6DFhF33c0J
	LtboXkmTMNFf5FnKgM1PjHvq5qrTOCnLXXAqccVzqid8IM87PqHEjrhZFZLvVoQYYZyaGjZhOzr
	mlOJPAohTGR+NEuMQJn8UQ3iOA1LhnkDtXLWV0gE9IACChZfIGfDp+ysRWNTP//qre75tOOQwH7
	8MAXb/VVQaG88tiG6CLc/j699b2e09oVfMsoPislNQxYgluQ26Ny4gwtFJHP4f8xdoJF7OzOsU7
	q1IcN+YuotiGxbvqQ0yLdABjbMQ05GLpxibWbzDUgcN3dWF0ytRdfVFlJLNz6LFXTnVT0PfKCV2
	5TBQhrNk1l7JTb3Lm03k=
X-Received: by 2002:a17:907:3da5:b0:c26:22ae:b66b with SMTP id a640c23a62f3a-c510e16a0f1mr169669366b.15.1794994702657;
        Wed, 18 Nov 2026 01:38:22 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fe23sm75661266b.1.2026.11.18.01.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 01:38:22 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Nov 2026 10:38:22 +0100
Message-Id: <DMY8IM8YE31V.28096PQXT9KV5@fairphone.com>
Cc: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert patches for OpenSSL 4 compatibility
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Pavel Machek" <pavel@nabladev.com>, <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
 <avyUNwowVKWAJDj9@duo.ucw.cz>
In-Reply-To: <avyUNwowVKWAJDj9@duo.ucw.cz>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 00:09:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25005

Hi Pavel,

On Tue Nov 17, 2026 at 6:51 PM CET, Pavel Machek wrote:
> Hi!
>
>> On Arch Linux the extract-cert tool from 4.19.y-cip doesn't compile
>> anymore due to OpenSSL 4 upgrade which removed some APIs used in the
>> host tools.
>>=20
>> Backport some patches, taken from linux-6.1.y to fix compilation.
>>=20
>> Note, this is the first time I'm sending patches to cip-dev, so I hope
>> I'm not missing some contribution guidelines.
>
> I believe these are not yet in 5.10, that would be first step.
>
> This is not usual kind of bugfix, nor is it backport from a member
> company. Still, I'd not be opposed in taking these, provided 5.10
> version is taken first.

I've submitted the patches now for inclusion for 5.15 & 5.10 stable:

https://lore.kernel.org/stable/20261118-openssl4-515-v1-0-e1fbd1da96d4@fair=
phone.com/T/

Let's see when they get in!

Regards
Luca

>
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>
> Best regards,
> 							Pavel


