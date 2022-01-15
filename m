Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD63C433EF
	for <webhook@archiver.kernel.org>; Sat, 15 Jan 2022 05:41:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.4275.1642225267523050525
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jan 2022 21:41:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 20F5elxE008075;
 Sat, 15 Jan 2022 14:40:47 +0900
X-Iguazu-Qid: 34tr73YMXokISNoH3Y
X-Iguazu-QSIG: v=2; s=0; t=1642225246; q=34tr73YMXokISNoH3Y;
 m=8e+XDYAr7m09xRmnvjbbUeMG8UJ5CgRQRwUY0Kn6e4E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 20F5eivT008919
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 15 Jan 2022 14:40:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0lIvlXPiSfYpHtyFEpneSYXzK4Uz7BPDt8sVUPVzA4ApXj5xWbY2LwqlXdAqliON6oKSqlR3uzo+sZexGCjugdhKrdXVQbYCsUHn/dBm4axFVpd1DJ4D1cpLjvbTT4WoShyiWkypWSxi+9ZIG0b9l5q/4NYD2uil58V1geod+44fFLlabWsCnJDJZ9II5LjcQdQRepP+g14U0Pyk4EN2PwM9Fc2XGUctGpv+htq2OJO7dU6D8RypMLzjY+YEHyoxxYBYzeLS9On1zz8oJLIVAIgSbpOkySUq1Uf8m5V9cgfBjnFCSmNOh+xYvNcTUXY0OXN7p5UNbFwvfrDPeyL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuH1RMAZuha4e5mgH/JMFz6UVHMM2IWPqwVY2RJecaw=;
 b=bjmGfJ4Kd1IuRBjh9dluRgQcEIUsADcDlHUb1tBigBnrhwPb9K++opqILCAMZpfPAszjUKWeOxcfGPcyqJHhuRXyaT1Kog/WzEV6FuxpAHGBsEzHqjnMqz2HDM1YOlrixd54U0nqkZvu/0AUtnEz2IOCvvdMbX6aMkVlQyJMX1ff8vc12FSqnvjUUn1VosciaWr9ibvB1JmebiJIyq2LMvCIqyXVlgNGZBXI0rJoLQaIj9AnJDshaNd/0CsQf1zY8PQVTMnOzUcw1UxSpK3LMEWUQXjPigunGPx0Hx5ezxEoGYkCozn4GijcBEuNs9szWJ+Q4nhnoFiY5fxgkFkPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.225-cip65 and v4.4.296-cip67
Thread-Topic: [ANNOUNCE] Release v4.19.225-cip65 and v4.4.296-cip67
Thread-Index: AdgJ0kgXObINeKVGTpeQLoD+HhRGBw==
Date: Sat, 15 Jan 2022 05:40:42 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252C3946D52C50AEA3621C092559@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1755da3-a339-4484-9569-08d9d7e991f6
x-ms-traffictypediagnostic: OSBPR01MB1813:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB181376B0FB635817DE9C7F0392559@OSBPR01MB1813.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MS3h/ap2/48XuUVD5c74fCDg+TMokKOFyQ7zymuzsEhxUMLVEC/FpYNFTdSKOpc0T01wkuQV/MWqUNpYhVUZSgL1HBQVm3WYbdQRBZaunzvreXsq5BsWD/VyI+RqpbMquFO0o29fC29hq6AYfV83YzTi74lV+ioppZw2fCmD8nv1aBnTp3SVa1WEbXjCVOEsXZDRErArByGJTpvcxhIub7G2x1R6PnfnB4Q+oxWp42kN3Dk4Fgij56PBAjIAVpa27T91tIorMh7tsyST0uKuvoaOaUyw9YoA0DGqGXPvOmWCpy9mBXhfLQdYss7NUmtrPDS6UJvFJIdDApoOHqRNrDjghAGJwsA41JKna3w/Yy99i4Bf6JsfL80RMX3XqMK/F2cjKR4XZQvvwWDv/M32GGyHCUDW65Rqr+OxxWDFUiHFo/sFL3kw+XyX+7Kz5OmymvJO5Sk9tGQ2tAsOU+KorT76frNvbJwy76MS0JvVgdCjtpT7Uh1ACqrQ6DQI2kqcP3g51MvZmoDxUiW+sW1bcpx2BKhlLNwqWgi40FO7W/z7w2q6+G3jt0teSGpq+epwasPJzKpoEvntpprltorY/2/R/xKPW6MP1RnJ2q3K3YlnNoguUHphccsyStrf85kPA36z2SqzpI812honCYdM+n9k9vb/wCcX/NxbXk9fS4mkUKc8ArE7JPLPMwmjHukyIDS+I9Ht1xct1CmLy7Ox3646L55TTN0sPIQ2LcsYAVkaHWHVWoGb6FeVIffPx9oBVnaXdp84OX/gAzkXtirJ0YTpX9o0ey70d/VY/aoWNW8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(7696005)(55236004)(71200400001)(6916009)(86362001)(8936002)(5660300002)(4326008)(6506007)(52536014)(26005)(8676002)(55016003)(508600001)(2906002)(66446008)(966005)(316002)(9686003)(122000001)(38100700002)(64756008)(76116006)(66556008)(66476007)(83380400001)(33656002)(66946007)(54906003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Vm9VeFh0TEU3K0RpVE5jVC9VWXRDL2F6VHhYY1p6UHZNdzVLdHRWZU51?=
 =?iso-2022-jp?B?ZzBoVjQ2Y2w4NEo2ZGNBNVNkd3NjYzFNb3I1M1QxcDYzVjZvVTZ4Qytu?=
 =?iso-2022-jp?B?dzlNM0Q5MmJkTVd1TENVcUh2MWNYendUWHlCOFFoMjJvKzMxYTNoTDhT?=
 =?iso-2022-jp?B?Y2tQakhiNmJTQUxMWWZEaDVyTzlxQlB6bTB0UUtTa2JyRzhkaURyd2po?=
 =?iso-2022-jp?B?REpkZzJJM3lBc2doamhPYWF6T2FSZkFEUWN5d0NhMHprMWsrZTJOa1hp?=
 =?iso-2022-jp?B?TU5HVkR0Y0FjOVcwM1R3cG9qS0JGY3kyWEg0bHo5eHEraVdqb1FwaGda?=
 =?iso-2022-jp?B?QnlrSVk1dGRYeFM5elVwcTBSa29IRjkwcHM4ZDNRUjdtT0l1Um8wTGNj?=
 =?iso-2022-jp?B?Ung4Q3FZSXNlYmpBUGZHdGw4Z1hpY2YxdmJEbGtndG8xMEVHNkJBaTUz?=
 =?iso-2022-jp?B?Sjk4NFZVYnJ2eUY1SDhYVFhvNWxtWEhpNnlxVGpZa0dhOTJJOWRmdWxW?=
 =?iso-2022-jp?B?b1ZJRktyakRnNlVwazkvcm44cEVscEU4TnBtY3lQK3JXb1gvc0QvRkRz?=
 =?iso-2022-jp?B?U0FhQlU4Yll2NmhNWWdLcDlZQWtoejdsMTV1Y1N0R3dnUG5nU2dZSWNR?=
 =?iso-2022-jp?B?ajhwZkJFQlpOeDFGYnd2Qm15OTIzOVAvZUtlaHg1Tlg5Q2cvL01CNkJk?=
 =?iso-2022-jp?B?V3dyZzc2T3JZdFpySnJHZ1E4WFl4WEIvdlBEWXJUTk9HQ0V4R0laeW5k?=
 =?iso-2022-jp?B?aWRsSzJzMkFWQjByb0NxTWdJbGYrMFVEQjBFTU5VWnJ2VjA5cXlsQSsv?=
 =?iso-2022-jp?B?VklFaWpKQ0NONlZFMEI0OURMQkRiZk9DaGxhL3BHU0MzSkxFN3VQdHlq?=
 =?iso-2022-jp?B?MDljUWtIZlRrM0FWWkQwUW9sa0lFOXJUcUZsUlU1TDRqb1dsa2VjYzNs?=
 =?iso-2022-jp?B?Ui9mTllLQ0tmNVRoQ01vcEdlV2xyUFV5aGxaQUFKOS9PYUFRaTdDUGdR?=
 =?iso-2022-jp?B?c0YvQ2Q4Sm8xcmxieE1UQU4yOHUzTFlEWTZmMWlnVlVhT21DN0Z4K0Ev?=
 =?iso-2022-jp?B?RkVkL2dEK2l4OUhZaUJvWVN1YkcxQ042TVBjU2hWbmVRc3pDQVkrNUVk?=
 =?iso-2022-jp?B?T251R0ZMeEhEMENncDJ3T3JJTzYyalJLUDd1SUNjaXVyM1pqTXgwbzcw?=
 =?iso-2022-jp?B?NHh2Q0svbkNlNDNobk9hNC8yaGlEMktOYXM1VEkwZzk4aHNBYXRMTzdy?=
 =?iso-2022-jp?B?Q0k5WTdmd0gyVEFEYU9zNytTTmk5QlFlQUpabnlGRU91dGNoYVVkZnJK?=
 =?iso-2022-jp?B?S05NR1ZQbDFkS3Y4Ukk1UlpYc05xSUVpUTJFS2RtMmVCSDcxUEMrRU9V?=
 =?iso-2022-jp?B?ZktzU05wbFAreERkV1JUNEpERmVGNDN0YlJmK2tCZkt0RnJvbklNK001?=
 =?iso-2022-jp?B?d1FMc2tRRnowY1lSZnltdWFQTlFqZi9ENk4rQWx3elZqQ2EzTDdDMVQx?=
 =?iso-2022-jp?B?UVJQWDkyaUR5RXhWZW5xbm5CSlJLbkpub2M4QTlBSFBFL1ZCN2NFb05L?=
 =?iso-2022-jp?B?Mi9ybWQ2QlpTREx5d3k5QlJuS3h6M2QyWE9yL0JrTG8zM3J0azZndzJD?=
 =?iso-2022-jp?B?a29iOHVqZjNGakpCekY4SGk1aUI2c2d3NlE5RkhCOHFMR1dQNis2SzFS?=
 =?iso-2022-jp?B?bUI0WGJPL3dwSm8reDlZNXl3Q2lsajFxZnFYamtNU3IyTzR1LzdsMW5x?=
 =?iso-2022-jp?B?TjdoWlpDOGhvbFBNT2hNMTVIbmtndjlxVVhNd3FOb29ieVdoRkpoZ2FL?=
 =?iso-2022-jp?B?clMrZ2FQSTZCc050UUVKYzE4dHp5SFdyWk1QamFTS1Z5aGtBOGJjMWFD?=
 =?iso-2022-jp?B?cFJkOStsakZIWmFoQkl6c0l5ZmdoUzN3b0sxUWRjbHZpckxZVEYwU3hr?=
 =?iso-2022-jp?B?N1RKUkx0WDh1QnBPTmZ3UDA2cm9SOFZwS2NQOTFFODFYV3JSZEdKcFVZ?=
 =?iso-2022-jp?B?UWhvNFlBZDNLdDBXZFBqWUpYM0t4cXpVaG8wUnFjTW01QWY0TEdxR0VO?=
 =?iso-2022-jp?B?b3RYSHk4SVdSK2txbHNONEdwVFBTZ2JuNkllRHU2YXROa2ZRczduNDNs?=
 =?iso-2022-jp?B?ZkZ4K3BDZW4vaTJ2S2o4N2dqeUVBZjNlRktjWGdKb2lYeGVGQmQxMVYz?=
 =?iso-2022-jp?B?ZUp3MWJTbHV4OUhUZGF1V2ZxVjJhU2FEOHBNZmQwYlc4cHpZampWWGtp?=
 =?iso-2022-jp?B?NTJHUnhVWjd3UG82ajRIZ2RGWXBCejY5RHFGbzZiT1dRSWt5QlB4R1ZC?=
 =?iso-2022-jp?B?UWtVTVNndTVqeUhIVmF4SjhLRUpuSUYwaUU4eUthc1VxeWtUQXV2Q01G?=
 =?iso-2022-jp?B?RnFKYWppSDRCNGxoM1piU1NjYnFOcVp5UHRnTlJLd1NSS04zMmR0dDNt?=
 =?iso-2022-jp?B?RGMxYWUrdGRjdVBnUllQREs3dUZTMC84R2lhTmsxRXpVMFhYRkRJQlBm?=
 =?iso-2022-jp?B?MkZncjdk?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c1755da3-a339-4484-9569-08d9d7e991f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 05:40:42.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 svg3EzP8mDwiMrEormNKsiMIOkx7VJYLHAX3DprsAMASniyKQBWBN8odSmFO4GN6IP19Psm+k7ehT8hQeSPa2DpV7qVpKY+3uci9v+N4qxqmZT7Z3zwx18R8RH3t+kSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1813
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jan 2022 05:41:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7459

Hi all,

CIP kernel team has released Linux kernel v4.19.225-cip65 and v4.4.296-cip6=
7.
The linux-4.19.y-cip tree has been updated base version from v4.19.222 to v=
4.19.225, and the linux-4.4.y-cip
tree has been updated base version from v4.4.294 to v4.4.296.

The 4.4.y tree has a newer release, but we will release it based on the old=
 v4.4.296 for release of cip-rt tree.

You can get this release via the git tree at:

  v4.19.225-cip65:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      def5c8e4375baf1ae9c6421ce39f5cad2f3f2052
    Fixed CVEs:
      - CVE-2021-44733:  tee: handle lookup of shm with reference count 0
      - CVE-2021-45095: phonet: refcount leak in pep_sock_accep
      - CVE-2021-4155: xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP =
just like fallocate
    added commits:
      CIP: Bump version suffix to -cip65 after merge from stable

  v4.4.296-cip67:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      e113342a55e6846ad90c659a1b44d16f604e4b36
    Fixed CVEs:
      - CVE-2021-39685: USB: gadget: detect too-big endpoint 0 requests
      - CVE-2021-28715: xen/netback: don't queue unlimited number of packag=
es
      - CVE-2021-28713: xen/console: harden hvc_xen against event channel s=
torms
      - CVE-2021-28712: xen/netfront: harden netfront against event channel=
 storms
      - CVE-2021-28711: xen/blkfront: harden blkfront against event channel=
 storms
    added commits:
      CIP: Bump version suffix to -cip67 after merge from stable

Best regards,
   Nobuhiro


