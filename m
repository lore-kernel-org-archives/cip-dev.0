Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CAEC48260
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 12:58:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.16868.1706187502866995121
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jan 2024 04:58:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 40PCwKte1433244; Thu, 25 Jan 2024 21:58:21 +0900
X-Iguazu-Qid: 2rWhQ9h8C1yIwdbaC0
X-Iguazu-QSIG: v=2; s=0; t=1706187500; q=2rWhQ9h8C1yIwdbaC0; m=2joIV0qifgU+if2v/asUlQtqG0C0vNavLGJXF21PW8I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 40PCwJhA3363286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Jan 2024 21:58:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM+zstLmSgGMioEKZUBiYunXtx/D4eaYz3hTIIOqGVlDGlWnAZfnreyszgs1MJYRDZtiI5/zacPzh+ispgZomdm4oiXrl5U39obdLLAXfN8eqJaNrnvgMU+/epel4FtMt1bz58VH5ASYMD1d+Idvxi+SuYpNaLvPJEzeNJqI3Jcp1W3P61TDZU5hUyY1XDPacttFaUex97b1VjATSmDho0T3enLqAq6OzOg/oTolej8nF4WVPOpMDV0Rkuz1pKf2zjqyCZyrzbT5ZKNXLiID5e2vaSYn9h3huAo6nQgGE4A4mFHg1/d+mXS2aS33jirOj3mD9FP1ceB4DRl911pZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oebxEj0LjMgucWez1XSUV6KaKFwy5f4qSuOMumVzdwA=;
 b=SW/Mma43Ng5dl7JFE3vowhUexpn0G4S4jMQOrkA6lElmY/IDkszv2STyE2QIobfnarHXyA2IY9WBlMZAQKmF0euHswAmYGxsRR43u2rAaAlmavqaJnTUbt+Unkjsi+0J4TnF/Eq/XCTLUrJUnLK1pBuxBHA+a9P4PXSrg6E9+5ugDDAC1JzMpxUDPSE0FNLKh4raFyADZQOkJuF7Z45F6R9U3ADTTq100ACldOyUzVAVMV5ensjGaykKlEu6Tqg+QCjEVYHAYFhpY+cKXqFc+nNKfngZboVS3lcaOXISb7QOLUzSmbpZVJ/nW3ICxL9wBR5GffCUbsMnlfGllm1eUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat / 20240125
Thread-Topic: CIP IRC weekly meeting today on libera.chat / 20240125
Thread-Index: AdpPjgnURUvbsK0BSvqAsHDJdDgtLA==
Date: Thu, 25 Jan 2024 12:58:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388719318CDE0F32350DC50927A2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB8061:EE_
x-ms-office365-filtering-correlation-id: 8ceeb44c-def4-4611-1992-08dc1da54cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CYlRPk0Ww0v9OxQbasWYZS4QQ4qqDIMTU0AAymTnjeVvQYPJ8hpCqy4D7HRwdnHZPn3BYufHg4jVSeHlvEYibIO0AK5kmDkuj+kghVsusoQ5WmHWNkqvUcyhP20JxpfGCtAkRLFEzKDqyqziFdXI88PlxPHDbgDMev8D23ikqNKtYo5LivzAU7Z59aE5OwZvF6dMsmG/eZVRik53oAhsd5zB881xOtojz9inL2+sX9fGgudB1yZRyLqAVFOYCoG6NxJB/OjdoP4v+jvUf04/Tpr/RbvIWHgYlkUdwiH/lmDu5nqsKeGXXYF48hIN2W7u2eXqp4Nl1EUymG9gIamPSuS15hJmiDC87rvlOpYj3YvYGjuiDNb+QCrYoaUSVTp9xdFcYre46kHSOM1tbTiTasX9Wl1+lN9Tz131PZL6o6UUy2GrH8pruo9y0TznYJeYkgE4STQyeSucgWlhw1szKcE/O1kVoCOYvoafT+Cb6jn1Y3bemBKj57dU4ze2LJfxn3Jkm00R07311CvaPX2yGiqKLegITt2KO8ldVbY6Py1yOmYp1epf167XHkhM6pBJLFckE1cJYQTskq5DVNSZa3JpWvvwtNcr0CqQGg/f2P4pV4d+5Qoi4RxBwQnaolYi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(41300700001)(122000001)(86362001)(33656002)(966005)(52536014)(38100700002)(66446008)(6916009)(316002)(76116006)(478600001)(66556008)(66946007)(5660300002)(8676002)(8936002)(26005)(64756008)(2906002)(66476007)(71200400001)(7696005)(4744005)(9686003)(6506007)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VTR3aXZhRmJsNmVrV1JuZlZGTjgrd052UUdDY2MwenAyZ0RDMXJvYmVh?=
 =?iso-2022-jp?B?OFZTclZwYW0zbzQ1WktwUCsxemg2U1FZdnlwUmtORHZWNlJmekZ4dkww?=
 =?iso-2022-jp?B?T3k0enNKeUxCOUh2Wmpkem5ndE9tZzFkUU5LWjFYVzJ3dC8rRGVzd0xS?=
 =?iso-2022-jp?B?NzloTjh1TlFMZGllVVpLTkpIaGh0VjRoQmxjVytpVzQ2Mi9naE5pR3VZ?=
 =?iso-2022-jp?B?cFV3Q3k3NmRsTURlZ0VCSW5KQ1pJWkVmOUlkQU5RLzNjdUhwVG1lYmZD?=
 =?iso-2022-jp?B?RVlhMFdWNTVxdEdtcTI2TEhHOC93RUkyQzE2R0d2Zmc3ZmloeUVtTVk2?=
 =?iso-2022-jp?B?bUtHZENGWk1vV0FZSU1PQlYvWS9pbXJMZUhscEF5cFNQZS9lQ0k0SXFl?=
 =?iso-2022-jp?B?WHhZcjVxQ1VuQ1dlTEljbnV6NmV1YkxWQjFGc0dLNTdCSndSZFFaVTl4?=
 =?iso-2022-jp?B?d3NzQ1ZmMlkxT2FuTkJXT2JLWmxLSldMUjJaTjQ2SlhXeTlrb2hJa2Rx?=
 =?iso-2022-jp?B?KzNnWU9CazIyTk56MGNjanI0bWEwbUV5cXIxeWRiRGNXUVYzejU3b2JS?=
 =?iso-2022-jp?B?aTVsM0V6VkxkRm0xRkpnTFBtc2FzV3RTNFgxdStEM0t2REJTZnNxaFIx?=
 =?iso-2022-jp?B?Y0pjejduczNYamc0ZmRBUzUxaGxKRWJmZ3FDT1gxSUNFNlJGdHpkemRm?=
 =?iso-2022-jp?B?Z3VBK0U4Z242TzU4bFA5cHp0ZHNjZ1k1Mk5wNE5nUGZJS0EvU0hsdklU?=
 =?iso-2022-jp?B?ZEVFN2lrWGJQZS9TWDZhbG9Cb1lEbWduaU9hNU5IeFJJYXR4czVMaW9Z?=
 =?iso-2022-jp?B?MG9GUUsycHpadGtGck1iT3dBdUpBUXFTMGpVSTdNMHBHbVpHQzhnK2Fa?=
 =?iso-2022-jp?B?ZEYvaUN3TnZjWks2SjhvT212bmtBbjhhZ21nTENobldDVkkwUzhtNWlE?=
 =?iso-2022-jp?B?U2hVeldJNHdVNGhXWVhTSkgrU2NML2s4OXJoUTJ1eUwwOVhZUzVaK0Fs?=
 =?iso-2022-jp?B?WWoyeHl2OU1PZTR3ZmFJR0IzWmovL1N0YkdDNk1BUFd1WFpOR21sUklC?=
 =?iso-2022-jp?B?MS9SVmY2aGV5dk0vODVweGZqd2NwdkEwZFBMSERwVy9pTThkMDFmYUxV?=
 =?iso-2022-jp?B?cWdCVXBaM3VwVU9ubWxQOVVGQ1JDK0hyWG9od3JrYUJscGJXU0JEbFZm?=
 =?iso-2022-jp?B?WVV6R0RSNmp3V21lMDIra0p3MUdhTklJZ290OHhEa3poRHpla3Mwdmo0?=
 =?iso-2022-jp?B?MG43NmpETnZvWjBzbUpNVTVJSHNtdkRFSTB4aUZDOW1uWWNDbFZGUEVx?=
 =?iso-2022-jp?B?NXcrK1VxQjJUOWdKR0lodGJUTzFZdnBzdjlaa1RMRWFGWllJc3orVFZo?=
 =?iso-2022-jp?B?WStDK0V1bmVmbFQ0RDVlYnhhNWYxc0xzdklUOEZWRmpmS2h6czNtenRm?=
 =?iso-2022-jp?B?NUZIaFdINmlrdVFKTjNSV2M4dng5dVp3NURRVGFuMHhvQVRSMzlZcnZp?=
 =?iso-2022-jp?B?M3RiZmRYUktUTzZaZG0xWmZ5VHk1UlFZQTlrdlFRUlhkRmVWNURGL2ZX?=
 =?iso-2022-jp?B?dEZaWkMrL3ZYTWFtQWMwcU9KQmdodXdadnNTVXF3L3dsVmhpLzM2TkNn?=
 =?iso-2022-jp?B?NVNOWXUrZXJtU1Z3N2RudnFrNXpHZDV3emRwcE9LOEsyRVVoOTI1TUlZ?=
 =?iso-2022-jp?B?Tjd6aEVpcHl5dk1TQUdhNm5FcEJscnFCVDRYRlEvb1duU3RwdUdWNWts?=
 =?iso-2022-jp?B?OTVuckgvYWI3OEdMWWsxekVzSDVkcE0vRldtRjZrbk4wVHM3cFk4d3pJ?=
 =?iso-2022-jp?B?OWZwQmFnd3gvSXNTc0Z6S0k3TEVlcENLTUlobURsOVRud0ROaVNOeWpF?=
 =?iso-2022-jp?B?WHIwblVvcXJqSWdjWFA2Znk0cTFDbHlzZ3NJMG03aXJQdnkyZFQzeUxj?=
 =?iso-2022-jp?B?cVpQYXdwVHJOc0NXUzAzd1JmRzU2bmMvaWdGSFVaVjQ1bUFnNkdqdTBH?=
 =?iso-2022-jp?B?WDZXcmV2c3cyQlhBa25qNmNvazYycDBXb3k1UE1HVXBrbnBsUENKV2lp?=
 =?iso-2022-jp?B?eHV6b2tWTXVBTktvek1zQ1A4ZUhXRWVYOEZYNW5VKy9LK2hPOVhpUjU5?=
 =?iso-2022-jp?B?V25acDJqR1hPdHlOWnhyU2QrNkhRcm9HazExYVB6amc0QUtGcGJrTXA0?=
 =?iso-2022-jp?B?czNxSURKYnZvWG9Ody9qZzV6Z2ZhcWx6ZHZUMDBsNmhpTnQ3NkFvckU1?=
 =?iso-2022-jp?B?UTNKTW5SSmFUajB6NlZJQVQ2eGlBOWxTM0dMOWR3M25QU3hLd1lIOW1X?=
 =?iso-2022-jp?B?MDJyNzZxdWdLRTMxaGlIMjQ2MS9Ob1duemc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceeb44c-def4-4611-1992-08dc1da54cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 12:58:17.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mgqx24WJwUTcDngq/qo8NO5yju53Vx6ZSxygbbq0l1LF14Ec83oGqKHU86EFGP1UnP8TchaYQgfPI7dn1chHCZM4LNN28qjon+0i6AET7v2KMQHVngZbEikr2IVvRT6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jan 2024 12:58:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14458

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mont=
h=3D1&day=3D18&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/01/cip.2024-01-18-1=
3.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Best regards,
  Nobuhiro


