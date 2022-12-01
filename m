Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8FAC43217
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 12:01:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.69])
 by mx.groups.io with SMTP id smtpd.web11.41216.1669896056307238591
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Dec 2022 04:00:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bqvnJ0KI;
 spf=pass (domain: siemens.com, ip: 40.107.21.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqW8LgZFNMOjaUC3KSSkb36CwGFeI2zo1JomU4/QLbZ+wZ5Gq8lCmwfS+qg5hfe1ZMx+ERLs1QGlk0AJ1FXzhyu0E0kNpRKx410NWr1pfwq/kaULk7aEFxYbal6PHVFjz7SA3Q6GAWEIVH4+yLG/WCQOGjCw4xPT7SFM4QRbZgcNLtkLFU13LumO/7PAst9CsnkHbYn7M3VlCMxYazQpFPJhJs1KcPcHl1HxWFBd2hBUkuxkMwlsRD+9HyHW12j2L3v1/z8n7eZT1jJLQleKoPvxR67PTuIJEallZxnIvOf9elB+XWuErDmKwHkLREvi/uHW9v531pV55bf10xhp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUghUxwF4trYguhb09gyyvgQ77X3hSgezM3tuNY1R8A=;
 b=b+cud3cPSmKfb57qTfUX2NaezVAPBknWCVgRIAGDulvItStBWacCn8amSxXcZaH31PY9sBl2pcxa/1XxaltVtfGDvNw2CJ6MA94mqvggGg9+ngD0FpwdA+CmHeegUt8vBxFpoXTFaCJjgcgdd72wloiltql1FIWlZVUcrwysF4yDR8c2zZoQsu6luDtjrIsoI2VFDWarJdxzBJ1GxrTlQI1AAXM9b1gg3rIfDQ4kAVkqC6gQkiWwW+EcHnI2Ao2fAE3yX6fjv4KvH/qFdpgkYVv7t3vBz+0piZq+x0oJLHibI4wgrL+wBTiYOfLqu8vYsiifjANVVaKuFgmlvPcVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUghUxwF4trYguhb09gyyvgQ77X3hSgezM3tuNY1R8A=;
 b=bqvnJ0KI6w1aWIhmO8Hn62VLmAHbMyxeSyl2vVdo00IOSQ6qyaQLKPfLyU3Ztj2U0haEMLdFCEpsMJ1vHf0Szjb5w2CWvmkxcQG+29DBFV6Lx3bcB7JnTOEFmhTPbQ+SJOhF+CwPdSutdMDL/2PHk4I3dlpfHWk1lT5o/ZWLJ5+eOcXG2IxJS2igyOC6wNI5HfBFCqf3z3YO1Dl9/8OY2fMiKPsHAxbGFtUkOqeirRQPWU9v2VbULflsTqgs7nj3Z/cfIq+r/j1gPp+d3Cj78rErX3KwAix++T73F/U0fXo8QZYChzsOhHwKehgZGfoKtQueOFAEkVWA2IureA7/pw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 12:00:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 12:00:52 +0000
From: "Kiszka, Jan" <jan.kiszka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel
 Machek <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: IRC meet-up today
Thread-Topic: IRC meet-up today
Thread-Index: AQHZBXyPR08W5UExKkuF/40mN4Zerw==
Date: Thu, 1 Dec 2022 12:00:52 +0000
Message-ID: <ABF8124F-6AAA-40EE-B39A-5460E90661FA@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB6181:EE_|GV1PR10MB6073:EE_
x-ms-office365-filtering-correlation-id: 4fbdc1d4-84ee-4b32-69bd-08dad393b226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B5zK1MyZj7LqsJ2YoqsKxHOiewUUe+ddkS9AzUuAQvZzrkM/eY9e5tSqd18WlqYEAfN5dpL20Jzy0VEDaLO2hgzVuAfqyJj4q8ykI9yQv/Tub8BxojAng09UE1pML8oMzU+rJElpadOLzpcofwgCDBnMpDCVJV8omJGg1mUvWJgnsSdqKKyq2e+1/AzcJX878pZNuN1Ixjyv2VTcXONRAd5Te0LjXXaBoAmkpRbmwCOMyz8WYH9i1k8B1X+AqgSa/AKivNdruqqKdm8dOuN3WiYyrxKRMp0DKPo/MDpmxTD4Q6GudaryxaAZZkisV7/uabOXmRxutkNsfFHdol6xc+2+bj4y0dCIwdM5zB8oIV1YelrcZysK+nlJmjICT1DGDac333iK/uvs+Mpy13AJCoTcqD/B8Gl6QUzeRKA1oy3lgaUIrjOLK4TBWenICKtooGoMS0lLJ9D3CQKi5Uxr3L69johkeL219YM0KpaBZEVORTT1OMZ3OFKbIx29aw3pon7KAUcZpc+sa4ikegNliL2vYYgZRBQ4vyXpvtg5kRB3+kLjeGGd+IN7Rh1bLGBc572wQDsef27LIlHbwPYmiLXzXWSMSRaJTvj/CwlJouuRIvolUgEiGJPJm+uRGUlr750tUuUHhZsG+3/cIMqIDalryCe/uv0Ibf49tMHkyhKXFc3ZLf+mm0ycLLAnJK1NUzzKeBT/T9WS+1gX0urHMFDRTkNRwcbYNprRX3kPr4g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(110136005)(71200400001)(33656002)(6486002)(38070700005)(6506007)(83380400001)(36756003)(86362001)(3480700007)(82960400001)(38100700002)(186003)(558084003)(2616005)(66556008)(122000001)(5660300002)(91956017)(6512007)(478600001)(66946007)(8676002)(66446008)(66476007)(316002)(8936002)(76116006)(2906002)(64756008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KjyQQZAeCTJXademekQz/kACCGvWrv+x9YqfWU7jX54DPc/XfYLBiMaRX54A?=
 =?us-ascii?Q?18x4UZmkK6umtm04/q1+wWX9/y74RrlY6CIMFhkRjy8kOmxtA4bbrfMl6Y27?=
 =?us-ascii?Q?aoQXz+bkoL4LFZX/PolYjON2Fp0yZvDMbSo9dCNgeHS6axTcZrH0XaDQ381y?=
 =?us-ascii?Q?V9kLuoYzhuS/tRlJln0aDBJdP2v9QJyklWj09NUGsqjjMUiB7sFw66TYGApc?=
 =?us-ascii?Q?hRvSkZSckZcbu8u55NwV0BCyZaxDALyKVnEZW9qQlxOYNmdc3irgpgoLYRs0?=
 =?us-ascii?Q?5Ynxzba9o6mWc3pShPVSv3OiZqVPTYz2LvjU8kk+b+nBmWUETfESwLF+u3Na?=
 =?us-ascii?Q?lrS1g1cudFIZni/nDGZOeA18eZ5lLgo6L7Y8UuoRFAWNWepk5dvmXN4ud850?=
 =?us-ascii?Q?2qTXVLqDKMalBjXr0h4BHBhkZ2UOHNalZc/6aUtUsZwQtQbumnObvFi0I3EF?=
 =?us-ascii?Q?dhRDy9OXLpqaCciafHq7OmqNwt7xc/2HbUbqxeteraTbWPhT1xAD01fQxTxk?=
 =?us-ascii?Q?qB4iTco982ZjZEHZPndIGdD1KeOQTq7nwku9hSegvqp/9MI5xQ0090yEaMoh?=
 =?us-ascii?Q?WPWQzNqaKvRDwOdp4+fx//jn0DX/bYy9lyuwpJ3ToO8gW2cqsmcn4CQ/Fzm3?=
 =?us-ascii?Q?qWT/1E0bYxdDZBplpznzbSM6ikcwB6PcV231sxIBC+mC5lHdNWCpGUqGTxNy?=
 =?us-ascii?Q?x+j0zBENoMWO6KbBywuGArZ0QC6p4TrucOb50flxHs1oG14ogQpNFzryyJMG?=
 =?us-ascii?Q?gW5/vWZWm7QcFUuNfP2QS3AJ/uzRABpgcMSMBun5x8cJCzF+Eg0ZrrsSUQ3L?=
 =?us-ascii?Q?QNxMxA19PRVYTPjo/QUUEm5wBJlxm9g7BTylTvuwxa7QfEbUZMTGafI/UzCu?=
 =?us-ascii?Q?/kTN8e4pR+Hp47y5h4KkCbfrJ/8e/B/38Trju+tnSauJqfqe7gujExW069Lx?=
 =?us-ascii?Q?aJj/fyNeZuMpm6VuCkVP6WjzJL6iiDgu97yqURc6hRXPPnfbTyQ87/jameiD?=
 =?us-ascii?Q?xgBDxjy7gIS25Yua4JOSUKe9mBAOva7/yKximukJcOin9UQ3aa9hqB5rQn/y?=
 =?us-ascii?Q?8lf88wmlKVkOjZSrlq9XwYkLU4uUV2QTpwaaKhTiXJRv6bsZ0Q5Snpy4u0cv?=
 =?us-ascii?Q?IRPF+2Adv9uuM+mAsBvJHjacCzfpmiiL3OkvTqytrq4PN5LmtW3uPhv/hT5i?=
 =?us-ascii?Q?+HP7g6EDmM5PYv6JttkWXCd37k3dEe4x8h4tMjqF4A5XDWOYP1Z6Uu5NHzJj?=
 =?us-ascii?Q?adgyZXWHcso0aNaQhwHHs4CY7uFsOlAvoOj5dWTgClxHsAmD+SH4buCEOQUx?=
 =?us-ascii?Q?M25UcJOpeBXOEYCbvl8FhSc2xUNkT0kgy8oyFVT42j2oF5FntSeXclDHyN3M?=
 =?us-ascii?Q?X1+xHJh7NmIZLLCKOWpjTyOxKc2YWnD3vnxtrvaXbtaYoBpprO1DGI+4LuYs?=
 =?us-ascii?Q?GjVG7cBoyOOO4SPEWFNgkDu1gnXGglzFf2G+i2StysPILlIzIPXVKLQhnuw4?=
 =?us-ascii?Q?0LGOFjKdA3L/8vpZeVQYA7+f5aHT9vtq0HUin1S5Lj4M3SdH2sAvR3Eq03vO?=
 =?us-ascii?Q?YEco5j59K7OwOOnoPdYWLl7qMvHwFHIhzRrra3ZitCOWJ0zjAV8req/HcA7R?=
 =?us-ascii?Q?0IHODW+ZuqWVGaN83Lmax4+EY6KUxsx70z1a1TcI0A/W?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19DE2DCFBEF1A14B89E9991729B88648@siemens.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbdc1d4-84ee-4b32-69bd-08dad393b226
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 12:00:52.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+t7wa7z/KdbowXM4pMJdqjzHfwIx3lPlZypHBcx2zm9RqXrPq+0yfUph+50p1Gz6yHJCH+N+Saynw7wRBbI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6073
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 12:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10152

Hi all,

Being on a retreat, I missed the notification today and will not be able to=
 run our regular meeting this time. Please organise yourself - and sorry fo=
r the late notice.

Jan=

