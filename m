Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD9C7618A
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 14:56:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.84])
 by mx.groups.io with SMTP id smtpd.web11.20114.1678458058220575046
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 06:20:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nfZZvKly;
 spf=pass (domain: siemens.com, ip: 40.107.100.84, mailfrom: amy.fong@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhDKLMOqHTyYUKxFMKHA+CkRbXE76xYbjFn+ul3oVjwSxQp+cd+ZvxYHV+1bxBVen/ZQIy+rN8DzL7wb9bltuJ2Hy8EbVvhX4HkuATAMeY/XzxngTPPcvFBLzOyLzPJJlK8skbpNzSB0r8tbEBPU7RVI8HXrUab4Xm2SQRnRuK0RX1/Rx0+lazVgzUeqvpeCCAtien0GFgJjqLHy5oHyD76h3ZHb5VIMoUT2dh/o9t6v8EGv1U7cYgyzM+Sp0CgoGoIOTWVxUfGeNl1ocXle+LXjFV2diZ0sZ9lPB3JO4bqybjXexo0kotpBDML1bqAJKrfHf8XJUmXV6/CAY9d3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg/O7rRIm25IzT8EwRkXGJxhvL+iffQORrbcaCHvSWk=;
 b=dQfiEuzN40I3Ck78aSOnTrbzg8B3cJrd+UdoDu2j5ERC5s8AWwHdv+2bw8tahheZXEme0I/KrnTqnXSlMBdLYvaUV77AzZ3RRrd2Ie5A4OrlCiCQV76ewZ8lhRnIse711yMMxMWYAL+DibHdNCsYITElZEjd9YOuOqxdHJSGmUlyp0PPc/Vo5mWQWM/EdaRpRJsacSTQoNGaLiLxh5mkNuCHx2X06UWvrcWkEeaPFHx6xIjIHY2M8SQHeJrQCZRkQDRdWoe07TBrOs1FlWbMXoUI2xh3DkZcAraIp5+sP9tplP3DMLUZwU5M+RFFMcjol3r/VcNGdcT7PK1sBL6P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg/O7rRIm25IzT8EwRkXGJxhvL+iffQORrbcaCHvSWk=;
 b=nfZZvKly8jEK/TuQDwqLd2HkXDpVrKv2pQss4j0D39qI56MUCYeXrQY+qeUPcXcIyL3CijgRdf/IX0V/ASxmhf6tzanxVxXQPZc46Qyij7SG93SGqjKUiBGsL87RtkbHeqq1JYTzlKOrQ079Znygi4ZZ6fqvmpWw80mk2iMEBce5RX4c+din0++KTmu8kIdfi1eFYMsuTky7REIPejSvBbd5eZS+BxBe5AteXO5/8/wGaYGN8azJuhkdNKDUqG7vZ63fl90GqwMnf8Nx6VfjP4p/+er49YUZ8j2NAAIkFvvGiYXN5Uz4szIMcBPTlb4NAd63KJAzO/SGU0Ay+9Y4lQ==
Received: from DM6PR07MB6377.namprd07.prod.outlook.com (2603:10b6:5:17e::32)
 by CY4PR07MB3560.namprd07.prod.outlook.com (2603:10b6:910:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 14:20:43 +0000
Received: from DM6PR07MB6377.namprd07.prod.outlook.com
 ([fe80::a85d:753e:af00:ede3]) by DM6PR07MB6377.namprd07.prod.outlook.com
 ([fe80::a85d:753e:af00:ede3%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 14:20:43 +0000
From: "Fong, Amy" <amy.fong@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Amy_Fong@mentor.com"
	<Amy_Fong@mentor.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel
 Machek <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables: autoload modules from the abort path
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Thread-Index: AQHYBktElNe17YYud0qR5xYccw4dGaxdEyGAgAB0NuOAAJSDo4KYYq6AgAAraa8=
Date: Fri, 10 Mar 2023 14:20:42 +0000
Message-ID: 
 <DM6PR07MB63778FA6CC6B6E411B01DE2684BA9@DM6PR07MB6377.namprd07.prod.outlook.com>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat> <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz> <YdyTRgrErYXoQzti@cat>
 <20220111090218.GA22781@amd> <Yd2XhiWzYwTbFp/c@cat>
 <20220111175356.GA6859@duo.ucw.cz>
 <0275387a-2c4d-164f-7746-d61abf40c6e3@siemens.com>
In-Reply-To: <0275387a-2c4d-164f-7746-d61abf40c6e3@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-10T14:20:42.375Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6377:EE_|CY4PR07MB3560:EE_
x-ms-office365-filtering-correlation-id: ca3c5e74-3806-42df-066b-08db2172a1fa
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yVdGozex02fBkWYdR6DpZV/bI3x/yGnOFoRfLtrXY3HuMTU7GzDb7rozqoAHwtfmlTo74ENDAZtPL+wXDgqkI9LxR864C0Dql9IcGs0FE/PwUeKhfw9wxRVa8LRKHqOo4FRNSCeC/Vg4ZaGib+590feFomEdRHyHyHfAPMSVpcdcCbmeZxhpAhvKMgtuDcX836tybyZ6YQ05aJwyg8tDe/FAJvkrAdnPw/Ctcdo101C8WyWvKPuqZnTrfR+e/av90EmTaYFO6WE8GdHR/Jr32j7VKElBvplAExyqCWyewbR7f71ctaz78GhUpZb5C3jrjOInGnSwXAvXiAaFMOXQRysEXeA94WLnyCHm+lZ+HbNtz94yQneQpX59X8ybi5fVERM00/7hNipw9+kajThSHrNZhTVvjlHlfkNZX30WQZpJ5hygwleAarSLC/9X/7MjccmBSdNTGHKvYsllXJUsfmIqszIgUkOj3mLFmbOAf+YFq/DltRfopf/EJoafFizZDqWL02XWUUkwyGk2UfiaJ38dLZZIEA1bu7UjwuMUJksB8gAG4mM9I5cfBG4jjM2TuMFxdgd0G+2yHPBJPYq5QEzC8uUQylE7MC4OU4FRdVcIRDw1VUQYqOM/RqI2K+K1Cv8Xq4eWFd1JhEqtBqJ8X4/Yn6O3i5s9u0jB632ist11b0xlQt3Bmo1uwiQAgqKBHm/36BcQnn0l7R8YUYhWcA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6377.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199018)(33656002)(122000001)(186003)(55016003)(7696005)(82960400001)(9686003)(53546011)(26005)(6506007)(83380400001)(76116006)(66946007)(52536014)(91956017)(66446008)(66476007)(64756008)(8936002)(4326008)(8676002)(66556008)(2906002)(41300700001)(5660300002)(316002)(38100700002)(86362001)(54906003)(110136005)(71200400001)(478600001)(38070700005)(19627405001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JfujTzkZ6o6p3PSvz1abl5oQnm6YO2B8UdmcvDvb4k9WDj/hUlfxoAe+FKRA?=
 =?us-ascii?Q?WDtDqfICS5+t1vJYxRShrj+3Sd1dlTROlp8Sm8sO5Rysm21gnUV253zSKYve?=
 =?us-ascii?Q?5tNteKwlIn/CLB9OI0nHDv+zQY5MEsZFC042wQY4FuYDCZ6IWyZLsUiKt2bq?=
 =?us-ascii?Q?njHNMIi2sNUFX1T1gpDNS+0QNlctwVKFh6tVVNmAytIPAEpC+VQV8gzHOWzW?=
 =?us-ascii?Q?66E5qSaTayD/9wRvB35lEH3V/t2MuCoDeN5iFFL8buXoWBVqMNXm6IzyHOgU?=
 =?us-ascii?Q?1wtD88K42sMCSOwxcGu5Y1lHS/ZnEHYfR4PVFXCI8JhWJylGX7sVZnNritlq?=
 =?us-ascii?Q?zMOAyLiiOA9GyodpURjbtyJ0yTuc+EmZgNjosjHKp4vtzUtPbER/EArmbH3k?=
 =?us-ascii?Q?Zkt//DEf+c2LhRCB+E6nKdFxeR/3jLBSdeYf0XyGZKXrDfnZEzF+mbiehtQI?=
 =?us-ascii?Q?ksz3hQNdKtDHAx1sSfZJjYlcB+zMLgigWM4BUmzfHCGJv0POr/Vx/XKJaAJF?=
 =?us-ascii?Q?hMw4LyFZi6diEiU7bummD1y2p77uBbRMIh37ftKkpPeFBw8h65vj1m/z4klU?=
 =?us-ascii?Q?/9ITZxUys1fzz/F0D5xbNpChWHojFnwsq0Ij41xWeeVjy0Wd+2l6iuCz6LaX?=
 =?us-ascii?Q?Nn3FI8XOZ+obFazr8X1XBitU9xQhu6R0LnIJKipr4Ig/33fnOn6JQjAEeh1u?=
 =?us-ascii?Q?92Jr025r9zLdVjFJcByP1OwdbaXCUbn+VUmhEbhpzSbR9Sero2wD6uP+rlYD?=
 =?us-ascii?Q?aGz8O0gIQ6xQsgcihM45xOnq/y9QQDRK3Z1LARFRJfVTqw7mDabBXRROZ1cE?=
 =?us-ascii?Q?OIJRF9dJRibMXmyMRXb3GbP6+1D0/nSXuoUrsu8CiabM6XIdLLuPzG1pfGGh?=
 =?us-ascii?Q?7yVU6FCc+f78zVFkFKf5rSyyxLfGHgMA2flv9ZWTp0w5MJGOSVG47c4x6qlF?=
 =?us-ascii?Q?6eKOoNuQzQC/WKrkd1eDq7tu5ACWkBm8aLodXU4y7Xe73aw8RxJKtYzF/fsw?=
 =?us-ascii?Q?gco86XcytoB8j0YWMw6/JGaJL3RybzGXf3WESzfThu1/z8jVKro2X0qLv22+?=
 =?us-ascii?Q?6Ss8HQQm1HZ4hFPgFSp38xH1Q13cz3/LnGJMG6SDWu/2+qlI9IfgIYXEa6Wd?=
 =?us-ascii?Q?3pZeLZIPjWallEYS/x9tD6fj8mwnnMj4BU3lpYGm7qmhXL+BSD4bqMwMXbLB?=
 =?us-ascii?Q?ZZcwHSbN+olPTARt/cRepZTovdp73r4tfOjURhx9OlFFBRGm1nS/LVFUBmMY?=
 =?us-ascii?Q?OsdX4BGxYoMjfnJcyE3PcYMfa6yVPPu7tH9fNPAPBeSUE/91SfCxWs5iahPI?=
 =?us-ascii?Q?3VJgWDFBdLOlT6IpTABmyO/zlseOEWPOIsDGJDx+boAV4fZC9RFzPFRUlynT?=
 =?us-ascii?Q?Gof19mCKRR/flO93GzlvKrdDg4tQFX0r9Evcj0vegTKalb6JEZrZFCB+1BvJ?=
 =?us-ascii?Q?TNAPKU81DF1t2OV/uUXveUH8+pdm+RKYlSCGQa5h8ALXRfnKoGMMNBV32gMG?=
 =?us-ascii?Q?diWgdwlwFTVEswBtu3g0qJURHLO4pu3t6ogxhfYmi9u8Ii7XLEAdlfYfcTAN?=
 =?us-ascii?Q?izt05/isHyUuYkpikWcP1EePoygtGar5MLXKWUI5?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6377.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3c5e74-3806-42df-066b-08db2172a1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 14:20:42.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mn0nytKfbwLmIAiKHhlEf+OybS/r3kIfozAROACj8wzJS9hS3wBEyG1E6UyWC4KZciDbW/og0eZEu2TmmkuC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3560
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR07MB63778FA6CC6B6E411B01DE2684BA9DM6PR07MB6377namp_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 14:56:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10976

--_000_DM6PR07MB63778FA6CC6B6E411B01DE2684BA9DM6PR07MB6377namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

In the last conversation with Greg, he wanted validation.

As I was not able to reproduce it, I asked Anil to validated the patches.

That was the last activity on the thread.

Sincerely,
Amy
________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Friday, March 10, 2023 6:43 AM
To: Amy_Fong <Amy_Fong@mentor.com>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; nobuhiro=
1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <=
pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables=
: autoload modules from the abort path

On 11.01.22 18:53, Pavel Machek wrote:
> Hi!
>
>>> Is there reason not to submit it to stable? You are describing it is
>>> as a bugfix, and Greg takes those. [Advantages are a) community
>>> review, b) less patches to maintain for us, c) bug fixed for everyone,
>>> not just us].
>
>> I will submit the patches to stable.
>
> Thank you. The patches look good to me. You may want to include sha1
> hash on the first line of changelog as
>
> [ Upstream commit c1833c3964d5bd8c163bd4e01736a38bc473cb8a ]
>
> ...as that's what's usually used in stable AFAICT. If they apply to
> more than one -stable version, you should mention that. Feel free to
> Cc me.
>
> Thanks and best regards,
>                                                                Pavel

A colleague just pointed out that we still have these internally while
4.19-lts is missing them. Did you follow up with LTS on the series back
then, Amy? Was there any push-back?

Jan

--
Siemens AG, Technology
Competence Center Embedded Linux


--_000_DM6PR07MB63778FA6CC6B6E411B01DE2684BA9DM6PR07MB6377namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
In the last conversation with Greg, he wanted validation. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
As I was not able to reproduce it, I asked Anil to validated the patches. <=
br>
<br>
That was the last activity on the thread.<br>
<br>
Sincerely,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Amy<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br>
<b>Sent:</b> Friday, March 10, 2023 6:43 AM<br>
<b>To:</b> Amy_Fong &lt;Amy_Fong@mentor.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; nobuhiro1.iwamatsu@toshiba.co.jp &lt;nobuhiro1.iwamatsu@toshiba.co.jp&=
gt;; Pavel Machek &lt;pavel@denx.de&gt;<br>
<b>Subject:</b> Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf=
_tables: autoload modules from the abort path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 11.01.22 18:53, Pavel Machek wrote:<br>
&gt; Hi!<br>
&gt; <br>
&gt;&gt;&gt; Is there reason not to submit it to stable? You are describing=
 it is<br>
&gt;&gt;&gt; as a bugfix, and Greg takes those. [Advantages are a) communit=
y<br>
&gt;&gt;&gt; review, b) less patches to maintain for us, c) bug fixed for e=
veryone,<br>
&gt;&gt;&gt; not just us].<br>
&gt; <br>
&gt;&gt; I will submit the patches to stable.<br>
&gt; <br>
&gt; Thank you. The patches look good to me. You may want to include sha1<b=
r>
&gt; hash on the first line of changelog as<br>
&gt; <br>
&gt; [ Upstream commit c1833c3964d5bd8c163bd4e01736a38bc473cb8a ]<br>
&gt; <br>
&gt; ...as that's what's usually used in stable AFAICT. If they apply to<br=
>
&gt; more than one -stable version, you should mention that. Feel free to<b=
r>
&gt; Cc me.<br>
&gt; <br>
&gt; Thanks and best regards,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Pavel<br>
<br>
A colleague just pointed out that we still have these internally while<br>
4.19-lts is missing them. Did you follow up with LTS on the series back<br>
then, Amy? Was there any push-back?<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Technology<br>
Competence Center Embedded Linux<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR07MB63778FA6CC6B6E411B01DE2684BA9DM6PR07MB6377namp_--

