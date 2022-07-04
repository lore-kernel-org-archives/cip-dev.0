Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BAC433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 06:11:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.69031.1656915085959776189
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Jul 2022 23:11:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2646B8Di003125;
 Mon, 4 Jul 2022 15:11:08 +0900
X-Iguazu-Qid: 34tKOOWMcOcJG71bM1
X-Iguazu-QSIG: v=2; s=0; t=1656915067; q=34tKOOWMcOcJG71bM1;
 m=4BBzi8xTsO0EBLJpW6oWJ39SJpC7i1aLmRIIBkusqV0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 2646B48W031380
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 4 Jul 2022 15:11:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0ttv+SbjXsZHaz7IRFLhjtbwAO8UYEi6h4z5FMg1SJ7FeIDmio6fkZzp/vxhJw1MM1IkbpEY5aoNSG1sCg5hLjMqWkrkz75pMRDDjFSygcYA0iYKG2cUCi2siCBWvFT4ot5utUGKJfAWt30ZQq+Qf5WUU49+esgLSRrye23NCIUPQ8QPjSsCSQ8Ps8e6v/LvCH+Yjzto3vPRvd+UkLYYik7tQZEubrMOhv26EsBZFjsHbx7ivVv2A01803xsGvimS4xUdMMf9jXiT4VLOArjSIHDBuYnpD0mGUhcUCbaAixVHId7hoZpS/wiJRVNJnRzzhinO+LpyX2OAW/uNNGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwY4YEZ6WBA1hEZLIgBatuzOp8G9jbZIKNjA6+TQiFg=;
 b=ilRBYY6risIbvJXA8psEF0q7xl8WUzaCoBEDqVr2XQho1Hr/XSOvcMtGd94ri9b7K8ZwspwFbijeREaxUKJTfsdl74FlsU7jHw4Z8gEUx+Xvijys4Zr3TLEbeJHvObBvjZGVJ08SpV+h23aiGOKtHO0TN8zS/JNG04fgLx8eimylXyaof/vAtBc/W8nQxlP0UsvLmY8lZDCtUk+aE1Y6IcIK/4THf/1DDhE+iI2v4O9HAaJnccqwABpepXF5YW76FbRXrdB7zFzBKc6Uoj3rjfz4Vyuu3eEzVHQ9dvbs3/4LloLpxU8P8RHI1bWrcqHLr6F9L/vFiLUprmJ/jb8FdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.126-cip11
Thread-Topic: [ANNOUNCE] Release v5.10.126-cip11
Thread-Index: AdiPbKJeTMWcX7zrSpexVmsI2tvS1w==
Date: Mon, 4 Jul 2022 06:11:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94205CF37D5B5772470C258E92BE9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da32c3b3-1812-4b1c-14b7-08da5d83f82d
x-ms-traffictypediagnostic: TYCPR01MB6637:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5n2oYowfxAFHI2JorDcqT3Iwg89+jqGNUFT/mxfhMuQ6Tt/ysbgF6CSE6YGWK+eevI9C6nB//qn+Cm2UbwQY/sxs8CU25XW4/4hsnkGL9qyIsZncATycnOjzVlzvUPjcAwv6Lcunzs88UUCslnGle3MJlr8jW/NNM/A1oWkOXSCZh+FjasiWAEG6ytbN2y9aAtiBdwFt3uZ7qD5joUjBkJ6xK8tZuyFEAL//4EFDvqMQSdqXKJ1JSeqVVKZdPaoLcLg/F58JXM7um6bqWDbI0XuRLYp6Cq+8P5/gMS/uHVVC1QO4kJTqeemCT1cj4GfR5QM80Zu+9yGwtAGO4+S6znMpLUpyJG0g9Ubh2mOli7XGeMqxvwrMrnmF621jZD+iCLwpZjt2GxElFmYcAjTaZHSYny8SDo1jr3dXX8IRSEkVpsQBWpgb6gkI6xEXx1cEtQBW9t2lSUzMscBTSfSBRK7KqPV/29Q7/hNJ5Aim6u4lwNgApOm3SUk6MPdNUq025Jv559YdW80BW4FZm3B2oitYRPHUnHHE4Zegd8NV9d3KH5kv/9xFRDFnIqxvvHZVll+N0OZTiOZskuQbhWSo9XzFEJ5eo71AWsq4SHuajo6jRLX670IMjkBpzS76owVkij3qRt6vxy9RPYngLCRwajC2EGpT3Ku3XF89ARkimKb5BIebzMqcOXtnyEKLKtL0Es86//HkTp4Hq1wbguMYSl5pwPAvC/mjBfQlkRg7sEGqvvoGzz/jHty6fLUPeww6g6PixDmsiBw9RW/zRCtY69IJXnmMup7kqMSCSHdexmwmHrNvtJjxhuNPzJUp/p+6pSVzuHtfxZeZgJsbR9Qv+w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(122000001)(41300700001)(38070700005)(186003)(33656002)(4744005)(26005)(9686003)(71200400001)(8936002)(52536014)(7696005)(478600001)(2906002)(6506007)(5660300002)(6916009)(86362001)(38100700002)(54906003)(966005)(4326008)(8676002)(316002)(83380400001)(66946007)(64756008)(66476007)(55016003)(66556008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VHkxWkJ3Z1ZqTkRLQklOaVR2QjhXWFlYZTQ1UGZlMEVxY1p1WldxZExU?=
 =?iso-2022-jp?B?N09aZkxPb1MxSkQ0R054OWhMZU9kVnhDY2JhZWV1d0VwdzVEOTd3eVVj?=
 =?iso-2022-jp?B?UHovVlg4RjBFMVpLeGxycXVXd2JYcElremd0aFBYL3g2RkR4Qm1xRnlv?=
 =?iso-2022-jp?B?eDZDREJvY3psa1Q1SktPWjdKRmZJQ2tmMXpLVHZSZXdNc0VLVGZJaVh3?=
 =?iso-2022-jp?B?SWUrZ05oeXJxNWlDNnBSekRtUVZGNW1RRVBLMHJNS0IwU3BTdThRV2NE?=
 =?iso-2022-jp?B?b2VHazFJNHlNY3ZraEFCbWxjUFU3OUxkYTdpalQvcmU1MEZQUWJmZk5F?=
 =?iso-2022-jp?B?dEo5OWNkN00yelh5ZldGWXB5OG4rK2UvMlVEQ1VMTzVzVDBhdSthVFVj?=
 =?iso-2022-jp?B?Ukg3SFdlOElQUlpIYjBIZzhneHdoMk1JM1JNZmhqUjh3MG1iVGU1eVMx?=
 =?iso-2022-jp?B?dHBXek5TUmJGQnR4MGhrU3RwTmpEejRaYlk5WFFxS2t0MkF1dDVvdEVK?=
 =?iso-2022-jp?B?WDRQYlY0bWV6K1lVdjhOT1ROeU1BTVhaUmN6ZktGd21tNW5sVlVxbmRj?=
 =?iso-2022-jp?B?ckdwbHJZUUdCSHR5b1VqUXk1OVpRSDZmUFlQaVJJM0JHRkphMHBxa3hI?=
 =?iso-2022-jp?B?UnN2V3NpM05pQmF1aEVhNDhVVlczYW45RHRrdEtXS1FLTDdCZkpBYzFK?=
 =?iso-2022-jp?B?WHpkMGhnc3FhTlFrcXhlREt5b3lYeUpraEt0L2FOT2psTzIzNXdVNzdP?=
 =?iso-2022-jp?B?YWxZSTlvcVgvaHZJZjBsd2xXdGpBOUlkUnYvVmYwYnVvei9tRW9zK1RQ?=
 =?iso-2022-jp?B?UDUvdHN1dFo3cW94NzEvdDkzRXlIMUtDYmpLYlYyaER4aW81Ukhyeng3?=
 =?iso-2022-jp?B?K0E1SVNVVEJDdFJleWNJNHI0dDd3cmIvN2ZTM0RFNGlISS9SZm02dnda?=
 =?iso-2022-jp?B?WWllNS9yeHZVMVE3Y0NuamJrV3Y3SHJSOXBvKzNiNld0VW9LeDlUd2pJ?=
 =?iso-2022-jp?B?MXUwd3BKeEx4M0xROHJsSDhxOVlvdVRva0EydlFVbkdQUVdBdzMycjRj?=
 =?iso-2022-jp?B?YnFvdExFOXZBbjF3M0dnTGhTVGhuUG1hT0Y2c2dTSzZmTWdtUkNoYTFo?=
 =?iso-2022-jp?B?R2NpMGFOSXBFalFSemM1L093ZXVBODg5cFpxeFU0RW0yeDBuN0lJM1B6?=
 =?iso-2022-jp?B?TnlNUzk4d2s5UVI1MHdpK3dwajMvWURZNHBUNHhOb1hiRGFKYkZWMUJK?=
 =?iso-2022-jp?B?eEY2UExKMHV2ZGZJaHh2RVE2bzBtT3BsQjgxZ2NBZVhXVVlrekNsVTRs?=
 =?iso-2022-jp?B?TSt1bHFjS2FaS2d0OVp3SkZjS3hTQllFT3IzV1lUQzRqR3ZibTd0aGYx?=
 =?iso-2022-jp?B?MWpTYTV5aE1jT0dZbXVMTHNydGVjNXlmbnl3eHBPZDNBQmNiUFNtZytR?=
 =?iso-2022-jp?B?RFFNLy9idTN6QTFSakVJb0NsNEkvK2JpOEtyYk9LTlJHdUt0QXJsMmVM?=
 =?iso-2022-jp?B?aG1uN2JZczgydFpMazExNklhUHBWSUpMd2tJSU92NFZrbGw4VjFHaUZK?=
 =?iso-2022-jp?B?bTZRLzV4RExSeWo3SlJRY3NabWFqTFpVZGRIREQwZGNIV0w1blJtUVdr?=
 =?iso-2022-jp?B?bTZ3S3diQWtLMlhQbzRxY0dObHJEK0pLUC91SkorL2FCTFQyQ0xrV2hS?=
 =?iso-2022-jp?B?NC82Z1ZhVWRRaDhuOXVOV2pnK01VUzJWQTlxUGdwS0JPdUVwTGYxbVpG?=
 =?iso-2022-jp?B?enV3bUJPL2s4a3lrdE81TWNwNWJ2TDQrZDlFVThOdnpBYnJaTU90Rmlo?=
 =?iso-2022-jp?B?OVpzNkVOSXZtYXd5RWw2OWtaQmdKVk45OG9HV1BUQldpYVJCZ2tWd1I1?=
 =?iso-2022-jp?B?N0pBbE43TU1RcUJEd0ppUzM5cG5VWks3TEFoMmpGUlhpWVI1Skg5enE5?=
 =?iso-2022-jp?B?ZjN0ZHRBL0l2ejZ2c2thMUJxdzgyOXNGU1ppOStocUN1dWxLczFwUDBR?=
 =?iso-2022-jp?B?bE44YmdtMEUyM0poTS9UU01lTkVrd3dIaVpOMk5VM1lNbzZaRHpCOGd4?=
 =?iso-2022-jp?B?MzZOZEY4S3RNZXQwaHpNaExQSjBjQURMZkpLTGJveThOdnZuVW5sdzhi?=
 =?iso-2022-jp?B?eFhWYzkxRS9oT1lTWXp3aVU3SUt1Zk5YV2V6WEJOTWJweDMrd3hELzZt?=
 =?iso-2022-jp?B?VUFNVHcwNEtzdjJ4SWxrYVg0YlozNXZyeis1VjRFbHNNdEhRTm4vU3Ra?=
 =?iso-2022-jp?B?SlFCZXFHdis3TWtLQS9rNTVWbGFIYjBZWEJKU1pYQThxaC9KaU53UFlL?=
 =?iso-2022-jp?B?dUNOSldOM1F3YzR3Z2dHMklmRjA2YVZZdXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 da32c3b3-1812-4b1c-14b7-08da5d83f82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:11:01.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 g3wr4NZUae0RLvK0hNAqgFCohEzs5VTX5qh5lwTN4nEMDKOr2LsLflFRsqIax9+zflgwcbmaDXoTpXqEPJ1AHG4lqmCWn1JXrVCLamYpuTYRixsvOpQQX/D98exI1eAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6637
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 06:11:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8642

Hi all,

CIP kernel team has released Linux kernel v5.10.126-cip11.
The linux-5.10.y-cip tree has been updated base version from v5.10.125 to v=
5.10.126.
5.10.125 has been fixing io_uring. However, it was insufficient, so the cor=
rected 5.10.126
was released. CIP will release additional release because io_uring is using=
 in some configs.

You can get this release via the git tree at:

  v5.10.126-cip11:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      400500e48ef52304feac8a819c6c911660ce59d8
    added commits:
      CIP: Bump version suffix to -cip11 after merge from stable

Best regards,
   Nobuhiro


