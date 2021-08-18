Return-Path: <SRS0=7Y5s=NJ=lists.cip-project.org=bounce+64572+6684+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E4C4338F
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 07:19:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2854D601FA
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 07:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2854D601FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QzkkYY4521723xIkxCfe8Ua0; Wed, 18 Aug 2021 00:19:07 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web08.51088.1629271144174223957
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Aug 2021 00:19:06 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id SQM217882A;
	Wed, 18 Aug 2021 16:12:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv1nEz8a21/M4T98Kd+YhXO7XpQYcpBIC2pQnlE6noH0s9lhe+6FC3aGGrwL7Ae3LQZQ/TZvt7m554IESyw9wrxvF3I9LY0pqgTEJielV/UOFlJ1xfEvq0mvA4mowJoIVhPHzhcdHKzhG5hKYtS5BONrMTijuLid50yBmmh/9iAiWx6VJ1EAitYvDwR0vBkQcPyij7WhT70yOygst6ziGvbBb0Yc+LZSPBKORPm7cdwNircyRPcPB6+Er83OF3y4IgEe1htfjHbHHWeRy4CYDBrhODf3gSelrdEEvkiQpQ8UjGpSyydLXVJ8HNsEtf2h0dHIxaNsngVWW7cXYdL0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD3cb4MqT+ZqJfmsgKN+08HzHY2SJOKoBsNB1qu57hE=;
 b=nL5gvs+KnEeCQnXuFuTu4GI+icg7YueUyA8VjvDbkwUJ3jniJvofNj3QUSwfj484FOwOIZp1VwRnSjnnqAgnRlQUgcBy2Fml7bv+nchPA3j/jtgfuqQGv3tjXmsoWYqo2GHX044iftTTYsSs+C1M8T1mf2WjC6HPbC25ytT8iSlXQXmkxls+pIbdS/yign6fsua4A/+irPsA2x34HwM4+qY3VWQVordM4dJ5yVsKJx/A5cUv5KVms2fMv/lCTcu5wnAxWKuj0g204AMiK/lWFEQOkc0kD7yxryeyp5f5EA2jYYA27DeVkGUMJj7txpXI11oWtkuMSHyNVeTG0FrunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYYPR01MB6636.jpnprd01.prod.outlook.com (2603:1096:400:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 07:12:42 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:12:42 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] IRC meeting start time
Thread-Topic: IRC meeting start time
Thread-Index: AdeT/i+rsaYf7nfrSTWhfzAPz18jAQ==
Date: Wed, 18 Aug 2021 16:18:57 +0900
Message-ID: 
 <TY2PR01MB49724B0C88AF035E898804DEA0FF9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3c30fab-bd0a-4b6a-600d-08d96217925a
x-ms-traffictypediagnostic: TYYPR01MB6636:
x-microsoft-antispam-prvs: 
 <TYYPR01MB6636061FADED52FD436DC97DA0FF9@TYYPR01MB6636.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 N6MS8O32JuQ70df99748TQiF0RyT6WzYbuUGfvwYPqLUSs45W6SNO4asE6gstTYEmBeRK9E4AZDUsiS/6Gsz01CuYNS87GZFxoSrjlIupJzTvD59XO8EkQjIANxuSFvyBwYMjik1YRTOxU+IYNIjNocymW21rVNCu3S6xU+aT3pST2cQ5hUAdml/mLxPruO4Zg5t3zm9J45GOgxrW4mwe8pRbpGwrXnFe6r+QSzQTdDWEm2ubXkH51xSHi/aBncSDwepScdkr8gXzMg0pWWcvRmg48WofF0+colVsHtPxz3rcAoJOpEI6VYFDmU9PbFlDQsYX9yDSZBiVLfBRS0VqXLZDjoCq29MH+MSxeRnsf3NztJZZXbZal+im6MddERujWVqpMX2sC0oGX8woUo/bEzX6fhEifui9owFT5skueXBABfRgqrXZN+goHXR29u+lDmfNqR0NdWjy2zlcTkWoMUOigXMML0iGxk36iLBVOOwehuaKbFrwhCF/03xkxAlsd+IP1aLEt3VxD/kik8bbdtuNi70CK+PBgmG0LC25ne0/3Un/UKbzRQj1gF4zGKCv1yToxBBtRKvU4UYykssuf5yBT1haIcQS1mbhOvIpDKmEQoGPpGXZUTn/mlGu7wRgNZTT6Z7Qyq6jVYweGgBXHK0iU5N6ojLm6GQSYKxZnSpP6+1rXlo9hxIOQ0c4wa8R8gOJipc38HMs5uND128n5fqd79BDg9XYyEHNrCQPFi/8oc9NZ2K+z5MziO/i0F2
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M29ZVHQ2SUhyc1RHdUxOa0lrWHNlcTFyZHhoL25QVlVLUHJ0Y1h0Y3ZE?=
 =?iso-2022-jp?B?bGpNeklMcTdtVndFbUh5aFdxMXloVVYxdDJDWUQxTXhXT2JwRzRZeU1O?=
 =?iso-2022-jp?B?SVcvQkxFSFpVeHJOWlZCN0hFUjdpTmltTkpKMmlvaFJJalpBTU9LckRO?=
 =?iso-2022-jp?B?R0RONlVnZE00cGlKUE5VSW1Sa3RQdmN1bEtWTkFNZFRETFZoZmsrRGJy?=
 =?iso-2022-jp?B?S2dZMWhDZ21nYU5CS0pZSm44ZHRwbmxNSXFnWGZ2b2dlbm9OUGN4VHFC?=
 =?iso-2022-jp?B?L2lQeEFlbjg2dlVRTTVYRGdSSUNvL1RNOGtZT3RtVTF3WW92WlYrTE9Q?=
 =?iso-2022-jp?B?c2ZabVlwY0xUMThBR2ozaUxGOXMwZDExMURkczVMNDhwQ1FjS1czaFp4?=
 =?iso-2022-jp?B?MDYzUVVuUEV0UDkydTdDSjJKbjk1Z3c2OTlVc08yQmtaZEFBeUx2R1Fj?=
 =?iso-2022-jp?B?dGtzdzZDazQ0YnFKTFV1ZUR0NHJSRlFyYUpJSS8rSlEvcVo0Z0NWM0tF?=
 =?iso-2022-jp?B?aVhiZkNOZ014blg4NUM2YmlSR1NFZHBBY3RCZXhoNzQzSkhUNVF2dUxG?=
 =?iso-2022-jp?B?cHNjNUZoNEU1SDg0Z1dDMHk4dGRxUmh0OHdxR0pwN2tHNC9SdkJVM0ZF?=
 =?iso-2022-jp?B?U1NMS2p3TUpObXBvdi9PM2dSanlhVDZzSTQ5ak1mV1lybDZBK0cxRU9G?=
 =?iso-2022-jp?B?K3AxbjJmUUIxdjI2a3pwRXc5VzNrNnFGSm9Sc01KelNKMjVwZlAxaS9W?=
 =?iso-2022-jp?B?QTk4cDlrc205aWpaNjBhSHNldWdvM0ZSOTZpQnJnUkFWWEV6RTFhcXRR?=
 =?iso-2022-jp?B?a1hpSUVoSFZPK1VZYWROUENTTUtEMGxPVVpUSFRvU3dlNmhwQlp6Vk1E?=
 =?iso-2022-jp?B?cUo3bk11alF5bSthR05VMHY2S3JWRmsxNHV3SDR2OVdscVZqczhtU0dG?=
 =?iso-2022-jp?B?ZU9aVVBRUEZvT28vdG9QWXQyYzdKYjdvSlVjMGpmMDNiZlVEU3g5TWVV?=
 =?iso-2022-jp?B?TExjN2hCQWJCMitwbVJSby9sVnFKTkxWUE5LYnNmdTM4RkNoZzJZMFNh?=
 =?iso-2022-jp?B?aGZmRWd0ZDQ4eGtTUWNudkN1OXpPZ2praVJEZ2t5eG55NHVKZ2Z4b2xt?=
 =?iso-2022-jp?B?amVvTFFHcWN6eUR6cmxkOUJ3VENHTWIrWENoblV0TGpiWFpSZWpiWGpu?=
 =?iso-2022-jp?B?NFNSb1JjbCtBZWJHVXhzblhhVzM0Ukx2ck1CYVVEbEFOeVBXZCtzZG1t?=
 =?iso-2022-jp?B?K0hHSmorUDFvd1NPc0JjdFJmbjZJK1NtRmYvTzVETzZWSjdGbzhvdVI5?=
 =?iso-2022-jp?B?dEZhUW5aWU54SzZMeUpXVW5FNG1JUTNYVWZ5dThHOHh0aFg3dGtGaUhC?=
 =?iso-2022-jp?B?SndUVkZ4dWF6cXFZL0FFVGRpRTV6UEJkN2NVNkRqYjdWZVVxL3hidmk3?=
 =?iso-2022-jp?B?MDY2VzZORXFrV05GV0tGa0pmdi9UYldCQW4vTEtad0pyaFRQYlkzZzdl?=
 =?iso-2022-jp?B?QnNtUGdwV01DRFM1K01nQ3ViRExNUFBrSHluMzBab2VZWXU5U3AvQVFa?=
 =?iso-2022-jp?B?VmdXWDBGSWQ0cnQ1YzY0ZkpZSDFDdUdRQWR5OUlkVHNzaXpERVVseWxP?=
 =?iso-2022-jp?B?WGZEMkFwWWhZd0JKSVVxU2R3ajVnbFl5U25hYWsxckhVZitObC8ycHJS?=
 =?iso-2022-jp?B?Q2taY0dXZkNzN1VrQXd1c1pzTzR0dGpwS3pwaGdBcHV3ZmxjWGFGWFhr?=
 =?iso-2022-jp?B?VUNkTlFWNTkrMk54ZjRhZkRvbWFXWVFZYXg2M00xSUJWRmlEUVpiS3hH?=
 =?iso-2022-jp?B?bzlwdDN1SmwzdEp0cVBZREpBc0JaYU91cUYrUTVhMjJJM05oWlo4d0lr?=
 =?iso-2022-jp?B?UVcwZllzZ281WVRxSnJ3b1VxVGtjemc1NGZCbFJXeUtJQWx5eU1IVnV2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c30fab-bd0a-4b6a-600d-08d96217925a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:12:42.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y77wwsWZAXk9W/wFAKWGTgxME1G+1F+kXbkQcXw8xNDEb2+1bUPtlNr3YwwME1WMR7dL9Bs6UpCqNnxXGaJOaqojpCZzV9IB24vrXfnLkAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6636
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ntybvbFdYpFY13hFzSRD3nmjx4520388AA=
Content-Type: multipart/mixed; boundary="Y7yXImYg3iLpdHkEo1w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629271147;
 bh=HkNDv/0EVWmO6PcUQWNmGjNlyQn7KfwHO9y0n6Ln9C0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OEueVbMrov5LXPVJNnn8Ya+9MC8Im6R1qhv4sonBzxixHqNPl60Rlugc8mIKvGL0P/M
 ZY43/9NzJJ0jCVrx6QR/Kg6WtAxmnwSO0QGAvZzBPIpbr8C0y8QSazEp0qEozvCLW1YKx
 6CI6b+CKPKEyB+oHYljRWfVhWnpQRB5NBnI=

--Y7yXImYg3iLpdHkEo1w8
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, All,

This is a heads-up.

We will change start time of IRC meetings held every Thursday.=20
We will start the meeting at UTC 13:00. That is:
  - Summer Time: USWest 06:00, USEast 09:00, UK 14:00, DE 15:00, TW 21:00, =
JP 22:00
  - Winter Time: USWest 05:00, USEast 08:00, UK 13:00, DE 14:00, TW 21:00, =
JP 22:00

This change is effective starting tomorrow.

Best regards,
--
M. Kudo

--Y7yXImYg3iLpdHkEo1w8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6684): https://lists.cip-project.org/g/cip-dev/message/=
6684
Mute This Topic: https://lists.cip-project.org/mt/84967414/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Y7yXImYg3iLpdHkEo1w8--
