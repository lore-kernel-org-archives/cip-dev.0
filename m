Return-Path: <SRS0=accv=AU=lists.cip-project.org=bounce+64572+4918+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC6C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 21:45:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B951B20774
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hJo2XPzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B951B20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4918+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8zKJYY4521723xo7musIpr5l; Thu, 09 Jul 2020 14:45:06 -0700
X-Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
 by mx.groups.io with SMTP id smtpd.web10.5817.1594331104100080040
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2020 14:45:05 -0700
X-Received: by mail-lj1-f196.google.com with SMTP id d17so4110052ljl.3
        for <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2020 14:45:03 -0700 (PDT)
X-Gm-Message-State: PMiNCU4WRe3n4cYnOMjqD7DQx4520388AA=
X-Google-Smtp-Source: ABdhPJyym91pCGCHYc7Zo3wMyMW3wJFQpJXLEhKiAsZDO9/TJvQ1cUrJkdXtfN+UWrN1/6ilCgAcDadQbAWub0NSFdY=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr14233386ljp.16.1594331102162;
 Thu, 09 Jul 2020 14:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <CALkjhPoyD6ZLG7-OZWYTDy6veyG75KGvWivUYjGPSiswPAVMBQ@mail.gmail.com>
 <OSYPR01MB5334F8DC340FC052DD2F8C04D9640@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5334F8DC340FC052DD2F8C04D9640@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Thu, 9 Jul 2020 17:44:51 -0400
Message-ID: <CALkjhPpdWMf3pkgbrdcSxuvh4S740O45t9ETbesGsKmneGbdoQ@mail.gmail.com>
Subject: Re: [cip-dev] Hawkbit docker image: Amqp connection refused
To: akihiro27.suzuki@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="kJr0GuF8QVOCVQqvZfuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594331106;
 bh=a3Ax5Ct9J17rD0RzlzvGqnZqmqGfcuClWpCqnRk2n2s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hJo2XPzPihOW0LipA5GdvH1/NGclYDqZqK7A8yEg6zuXHBc9oajGPriUIYA6l8EO1vf
 8+qexTx2VH5BY6H+DqE0FbWvpnmQ6ph0XvI6ni1F5uFYFMlA6TSocNZM/hFVeErEDoe4l
 BgqkVKr0RJgR6NiPr0Vvv8QQdIdxMZpFP/w=

--kJr0GuF8QVOCVQqvZfuh
Content-Type: multipart/alternative; boundary="000000000000ffcdf705aa09223c"

--000000000000ffcdf705aa09223c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suzuki,

It looks like my iptables were out of wack. Once I restored them to their
default configuration,  I can now access the webpage.

Thanks

On Thu, Jul 9, 2020 at 3:48 AM <akihiro27.suzuki@toshiba.co.jp> wrote:

> Hi Mohammed,
>
>
>
> I checked a hawkbit log in my local environment and found amqp-related
> error messages as well as your environment.
>
> The error messages seem to be shown periodically every 5 seconds.
>
> But I could access the webpage at localhost:8083.
>
>
>
> When I accessed it, the following messages were shown.
>
>
>
> 2020-07-09 06:34:05.291  INFO 1 --- [tp1510087865-14]
> c.vaadin.spring.server.SpringUIProvider  : Checking the application conte=
xt
> for Vaadin UIs
>
> 2020-07-09 06:34:05.298  INFO 1 --- [tp1510087865-14]
> c.vaadin.spring.server.SpringUIProvider  : Found Vaadin UI
> [org.eclipse.hawkbit.app.MyUI]
>
> 2020-07-09 06:34:05.299  INFO 1 --- [tp1510087865-14]
> c.vaadin.spring.server.SpringUIProvider  : Found Vaadin UI
> [org.eclipse.hawkbit.app.MyLoginUI]
>
> 2020-07-09 06:34:05.759  INFO 1 --- [tp1510087865-21]
> c.v.spring.navigator.SpringViewProvider  : Looking up SpringViews
>
> 2020-07-09 06:34:05.771  INFO 1 --- [tp1510087865-21]
> c.v.spring.navigator.SpringViewProvider  : 6 SpringViews found
>
>
>
> I=E2=80=99ll attach the complete log.
>
> Could you compare it with yours?
>
>
>
> Suzuki
>
>
>
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On
> Behalf Of *Mohammed Billoo
> *Sent:* Thursday, July 9, 2020 5:53 AM
> *To:* cip-dev@lists.cip-project.org
> *Subject:* [cip-dev] Hawkbit docker image: Amqp connection refused
>
>
>
> Hi,
>
>
>
> I'm trying to follow the instructions in the README to set up a BBB and
> hawkbit via docker. But, I can't access the webpage at localhost:8083. Wh=
en
> I looked in the docker logs, I saw the following:
>
>
>
> 2020-07-08 20:33:54.170  INFO 1 --- [           main]
> o.s.a.r.c.CachingConnectionFactory       : Attempting to connect to:
> [localhost:5672]
> 2020-07-08 20:33:54.181  INFO 1 --- [           main]
> o.s.a.r.l.SimpleMessageListenerContainer : Broker not available; cannot
> force queue declarations during start: java.net.ConnectException:
> Connection refused (Connection refused)
> 2020-07-08 20:33:54.199  INFO 1 --- [ntContainer#0-1]
> o.s.a.r.c.CachingConnectionFactory       : Attempting to connect to:
> [localhost:5672]
> 2020-07-08 20:33:54.205 ERROR 1 --- [ntContainer#0-1]
> o.s.a.r.l.SimpleMessageListenerContainer : Failed to check/redeclare
> auto-delete queue(s).
>
> org.springframework.amqp.AmqpConnectException: java.net.ConnectException:
> Connection refused (Connection refused)
> at
> org.springframework.amqp.rabbit.support.RabbitExceptionTranslator.convert=
RabbitAccessException(RabbitExceptionTranslator.java:62)
> at
> org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.crea=
teBareConnection(AbstractConnectionFactory.java:509)
> at
> org.springframework.amqp.rabbit.connection.CachingConnectionFactory.creat=
eConnection(CachingConnectionFactory.java:682)
> at
> org.springframework.amqp.rabbit.connection.ConnectionFactoryUtils.createC=
onnection(ConnectionFactoryUtils.java:214)
> at
> org.springframework.amqp.rabbit.core.RabbitTemplate.doExecute(RabbitTempl=
ate.java:2073)
> at
> org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTemplat=
e.java:2047)
> at
> org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTemplat=
e.java:2027)
> at
> org.springframework.amqp.rabbit.core.RabbitAdmin.getQueueProperties(Rabbi=
tAdmin.java:403)
> at
> org.springframework.amqp.rabbit.listener.AbstractMessageListenerContainer=
.attemptDeclarations(AbstractMessageListenerContainer.java:1787)
> at
> org.springframework.amqp.rabbit.listener.AbstractMessageListenerContainer=
.redeclareElementsIfNecessary(AbstractMessageListenerContainer.java:1768)
> at
> org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer$A=
syncMessageProcessingConsumer.initialize(SimpleMessageListenerContainer.jav=
a:1195)
> at
> org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer$A=
syncMessageProcessingConsumer.run(SimpleMessageListenerContainer.java:1041)
> at java.lang.Thread.run(Thread.java:748)
> Caused by: java.net.ConnectException: Connection refused (Connection
> refused)
> at java.net.PlainSocketImpl.socketConnect(Native Method)
> at
> java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:3=
50)
> at
> java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl=
.java:206)
> at
> java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188=
)
> at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
> at java.net.Socket.connect(Socket.java:589)
> at
> com.rabbitmq.client.impl.SocketFrameHandlerFactory.create(SocketFrameHand=
lerFactory.java:60)
> at
> com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.jav=
a:1102)
> at
> com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.jav=
a:1054)
> at
> com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.jav=
a:994)
> at
> org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.crea=
teBareConnection(AbstractConnectionFactory.java:462)
> ... 11 common frames omitted
>
> 2020-07-08 20:33:54.208  INFO 1 --- [ntContainer#0-1]
> o.s.a.r.c.CachingConnectionFactory       : Attempting to connect to:
> [localhost:5672]
> 2020-07-08 20:33:54.208  INFO 1 --- [           main]
> o.s.a.r.c.CachingConnectionFactory       : Attempting to connect to:
> [localhost:5672]
> 2020-07-08 20:33:54.209  INFO 1 --- [           main]
> o.s.a.r.l.SimpleMessageListenerContainer : Broker not available; cannot
> force queue declarations during start: java.net.ConnectException:
> Connection refused (Connection refused)
> 2020-07-08 20:33:54.209  INFO 1 --- [ntContainer#1-1]
> o.s.a.r.c.CachingConnectionFactory       : Attempting to connect to:
> [localhost:5672]
> 2020-07-08 20:33:54.210 ERROR 1 --- [ntContainer#1-1]
> o.s.a.r.l.SimpleMessageListenerContainer : Failed to check/redeclare
> auto-delete queue(s).
>
> org.springframework.amqp.AmqpConnectException: java.net.ConnectException:
> Connection refused (Connection refused)
>
>
>
> Can anyone advise (the complete log is attached).
>
> --
>
> Mohammed A Billoo
>
> Founder
>
> MAB Labs, LLC
>
> www.mab-labs.com
>
> 201-338-2022
>
>
> --
> Mohammed Billoo
> MAB Labs, LLC
> www.mab-labs.com
>


--=20
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--000000000000ffcdf705aa09223c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Suzuki,</div><div><br></div><div>It looks like my ipt=
ables were out of wack. Once I restored them to their default configuration=
,=C2=A0 I can now access the webpage.<br></div><div><br></div><div>Thanks<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, Jul 9, 2020 at 3:48 AM &lt;<a href=3D"mailto:akihiro27.suzu=
ki@toshiba.co.jp">akihiro27.suzuki@toshiba.co.jp</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"JA">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Hi Mohammed,<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">I checked a hawkbit l=
og in my local environment and found amqp-related error messages as well as=
 your environment.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">The error messages se=
em to be shown periodically every 5 seconds.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">But I could access th=
e webpage at localhost:8083.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">When I accessed it, t=
he following messages were shown.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">2020-07-09 06:34:05.2=
91=C2=A0 INFO 1 --- [tp1510087865-14] c.vaadin.spring.server.SpringUIProvid=
er=C2=A0 : Checking the application context for Vaadin UIs<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">2020-07-09 06:34:05.2=
98=C2=A0 INFO 1 --- [tp1510087865-14] c.vaadin.spring.server.SpringUIProvid=
er=C2=A0 : Found Vaadin UI [org.eclipse.hawkbit.app.MyUI]<u></u><u></u></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">2020-07-09 06:34:05.2=
99=C2=A0 INFO 1 --- [tp1510087865-14] c.vaadin.spring.server.SpringUIProvid=
er=C2=A0 : Found Vaadin UI [org.eclipse.hawkbit.app.MyLoginUI]<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">2020-07-09 06:34:05.7=
59=C2=A0 INFO 1 --- [tp1510087865-21] c.v.spring.navigator.SpringViewProvid=
er=C2=A0 : Looking up SpringViews<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">2020-07-09 06:34:05.7=
71=C2=A0 INFO 1 --- [tp1510087865-21] c.v.spring.navigator.SpringViewProvid=
er=C2=A0 : 6 SpringViews found<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">I=E2=80=99ll attach t=
he complete log.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Could you compare it =
with yours?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US">Suzuki<u></u><u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:=E6=B8=B8=
=
=E3=82=B4=E3=82=B7=E3=83=83=E3=82=AF" lang=3D"EN-US"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;=
Calibri&quot;,sans-serif" lang=3D"EN-US">From:</span></b><span style=3D"fon=
t-size:11pt;font-family:&quot;Calibri&quot;,sans-serif" lang=3D"EN-US"> <a =
href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blank">cip-dev@lis=
ts.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org"=
 target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt;
<b>On Behalf Of </b>Mohammed Billoo<br>
<b>Sent:</b> Thursday, July 9, 2020 5:53 AM<br>
<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_bla=
nk">cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> [cip-dev] Hawkbit docker image: Amqp connection refused<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I&#39;m trying to follow the i=
nstructions in the README to set up a BBB and hawkbit via docker. But, I ca=
n&#39;t access the webpage at localhost:8083. When I looked in the docker l=
ogs, I saw the following:<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2020-07-08 20:33:54.170 =C2=A0=
INFO 1 --- [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 main] o.s.a.r.c.CachingConn=
ectionFactory =C2=A0 =C2=A0 =C2=A0 : Attempting to connect to: [localhost:5=
672]<br>
2020-07-08 20:33:54.181 =C2=A0INFO 1 --- [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 main] o.s.a.r.l.SimpleMessageListenerContainer : Broker not available;=
 cannot force queue declarations during start: java.net.ConnectException: C=
onnection refused (Connection refused)<br>
2020-07-08 20:33:54.199 =C2=A0INFO 1 --- [ntContainer#0-1] o.s.a.r.c.Cachi=
ngConnectionFactory =C2=A0 =C2=A0 =C2=A0 : Attempting to connect to: [local=
host:5672]<br>
2020-07-08 20:33:54.205 ERROR 1 --- [ntContainer#0-1] o.s.a.r.l.SimpleMess=
ageListenerContainer : Failed to check/redeclare auto-delete queue(s).<br>
<br>
org.springframework.amqp.AmqpConnectException: java.net.ConnectException: =
Connection refused (Connection refused)<br>
at org.springframework.amqp.rabbit.support.RabbitExceptionTranslator.conve=
rtRabbitAccessException(RabbitExceptionTranslator.java:62)<br>
at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.cr=
eateBareConnection(AbstractConnectionFactory.java:509)<br>
at org.springframework.amqp.rabbit.connection.CachingConnectionFactory.cre=
ateConnection(CachingConnectionFactory.java:682)<br>
at org.springframework.amqp.rabbit.connection.ConnectionFactoryUtils.creat=
eConnection(ConnectionFactoryUtils.java:214)<br>
at org.springframework.amqp.rabbit.core.RabbitTemplate.doExecute(RabbitTem=
plate.java:2073)<br>
at org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTempl=
ate.java:2047)<br>
at org.springframework.amqp.rabbit.core.RabbitTemplate.execute(RabbitTempl=
ate.java:2027)<br>
at org.springframework.amqp.rabbit.core.RabbitAdmin.getQueueProperties(Rab=
bitAdmin.java:403)<br>
at org.springframework.amqp.rabbit.listener.AbstractMessageListenerContain=
er.attemptDeclarations(AbstractMessageListenerContainer.java:1787)<br>
at org.springframework.amqp.rabbit.listener.AbstractMessageListenerContain=
er.redeclareElementsIfNecessary(AbstractMessageListenerContainer.java:1768)=
<br>
at org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer=
$AsyncMessageProcessingConsumer.initialize(SimpleMessageListenerContainer.j=
ava:1195)<br>
at org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer=
$AsyncMessageProcessingConsumer.run(SimpleMessageListenerContainer.java:104=
1)<br>
at java.lang.Thread.run(Thread.java:748)<br>
Caused by: java.net.ConnectException: Connection refused (Connection refus=
ed)<br>
at java.net.PlainSocketImpl.socketConnect(Native Method)<br>
at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java=
:350)<br>
at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketIm=
pl.java:206)<br>
at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:1=
88)<br>
at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)<br>
at java.net.Socket.connect(Socket.java:589)<br>
at com.rabbitmq.client.impl.SocketFrameHandlerFactory.create(SocketFrameHa=
ndlerFactory.java:60)<br>
at com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.j=
ava:1102)<br>
at com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.j=
ava:1054)<br>
at com.rabbitmq.client.ConnectionFactory.newConnection(ConnectionFactory.j=
ava:994)<br>
at org.springframework.amqp.rabbit.connection.AbstractConnectionFactory.cr=
eateBareConnection(AbstractConnectionFactory.java:462)<br>
... 11 common frames omitted<br>
<br>
2020-07-08 20:33:54.208 =C2=A0INFO 1 --- [ntContainer#0-1] o.s.a.r.c.Cachi=
ngConnectionFactory =C2=A0 =C2=A0 =C2=A0 : Attempting to connect to: [local=
host:5672]<br>
2020-07-08 20:33:54.208 =C2=A0INFO 1 --- [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 main] o.s.a.r.c.CachingConnectionFactory =C2=A0 =C2=A0 =C2=A0 : Attemp=
ting to connect to: [localhost:5672]<br>
2020-07-08 20:33:54.209 =C2=A0INFO 1 --- [ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 main] o.s.a.r.l.SimpleMessageListenerContainer : Broker not available;=
 cannot force queue declarations during start: java.net.ConnectException: C=
onnection refused (Connection refused)<br>
2020-07-08 20:33:54.209 =C2=A0INFO 1 --- [ntContainer#1-1] o.s.a.r.c.Cachi=
ngConnectionFactory =C2=A0 =C2=A0 =C2=A0 : Attempting to connect to: [local=
host:5672]<br>
2020-07-08 20:33:54.210 ERROR 1 --- [ntContainer#1-1] o.s.a.r.l.SimpleMess=
ageListenerContainer : Failed to check/redeclare auto-delete queue(s).<br>
<br>
org.springframework.amqp.AmqpConnectException: java.net.ConnectException: =
Connection refused (Connection refused)<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Can anyone advise (the complet=
e log is attached).<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <u></u><u></u></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Mohammed A Billoo<u></u><u></u=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Founder<u></u><u></u></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">MAB Labs, LLC<u></u><u></u></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"http://www.mab-labs=
.com" target=3D"_blank">www.mab-labs.com</a><u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">201-338-2022<u></u><u></u></sp=
an></p>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
-- <br>
Mohammed Billoo<br>
MAB Labs, LLC<br>
<a href=3D"http://www.mab-labs.com" target=3D"_blank">www.mab-labs.com</a>=
 <u></u><u></u></span></p>
</div>
</div>

</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>Founder<=
/div><div>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.com" targe=
t=3D"_blank">www.mab-labs.com</a></div><div>201-338-2022<br></div></div></d=
iv>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--000000000000ffcdf705aa09223c--

--kJr0GuF8QVOCVQqvZfuh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4918): https://lists.cip-project.org/g/cip-dev/message=
/4918
Mute This Topic: https://lists.cip-project.org/mt/75385668/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kJr0GuF8QVOCVQqvZfuh--
