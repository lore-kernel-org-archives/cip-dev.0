Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C92C636BD
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:24:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.89702.1700742287402507860
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:24:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3ANCOOgk1115645; Thu, 23 Nov 2023 21:24:24 +0900
X-Iguazu-Qid: 2yAa8HlAn4DazrgIaW
X-Iguazu-QSIG: v=2; s=0; t=1700742264; q=2yAa8HlAn4DazrgIaW; m=Y6sl4FksU2JqDveDv91DP6fM6iLfYfgzxhl7XbgEE+c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3ANCOMK02324692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Nov 2023 21:24:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsNb0U4Rj5EeZlgMN1b1T2a2aW8BeW/QmtR+wtPpivR8bmp8M96ZVHeB0wY6yAn6c4Hipq1hYq2aYjprG4s3zW6e0afI0J8Hhf3tbTGiAAGrNmRXVniPNZ6bltDPAwhjpa05C/TRFsB+HjSwIUspEWB8JXXsmgOjCpsPPXky1X9LySPcVxA0fx/Yvsekf6qEv0ac7rZvOEnO8KXCuK/FNqm8IlHJ2C+EcuSqvcbTrZby2aCaj8h8XouWJ8UPZz/vPMUZ2RqyE7qS4PewowvP6NN95sQubT8cgiNKOE7SiOnxfXiCsF4BrpzuJOccM+bMTbk9XT0xsbhy9U6Fa1xzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTf9xwQDYdMw7Z891CrGo0BZTsjJGChL4L3NgaYgywA=;
 b=BUH4u9vFF9ts6THf9T3onLgX3jUb7uxzZdU5Tv3KA1274QeMYVqocH5cAvHgv4vC1Cdnp4f6uaG378DYn0JnF6gV2ma/t5+3nzlIKRnMAGO0iGzptGpEfTGpgM3YwBK1i5lpESvKhWt3p2jsVFpbS0YG2nPX9X+7aomP3YTmJb7pFk5Pp+d0GYWyT2+7KTQTChXZqVCViby4324E8n1n7A9h4YV9a1LE9Ohs6Zhkx2XO+f78XDQ6nfqprjKYMiuncMDH9jAQtToeMeoH5Fu/3JiTFUdhSphI5reca+7YAcFQGXQBhghP7kJWNOohlnz3FYLZiO1GYniuJC0RJ+IbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.201-cip41
Thread-Topic: [ANNOUNCE] Release v5.10.201-cip41
Thread-Index: AdoeB7sEJXvJn0BKTsKFAZiD1pa+Wg==
Date: Thu, 23 Nov 2023 12:24:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245E69CC17A667ACAC37E4792B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS3PR01MB9691:EE_
x-ms-office365-filtering-correlation-id: 6ce7f3ee-a271-4d3b-f538-08dbec1f1dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TU2seo6E7xL33qwRwh3C5Zc1CU5pszo5xIb8w5UT82i7aq5Cj28J1md9Jl8E/JijF2dm0ZBP8SNAgbBVkhxF6ngOnQR/ODUUoJGuDCmkPh3KD+eC3ay2XQvLq+WlcLwUq+ztr7OrKagX4fqOy36AuI+0aTJSBvEhNcWq9Q7BzQCH6TkaZItRUNXJ7HCDE08T5R+T8q3xPvRoR2dUPqwhuVjDaKweaK7WXQMqLa/lxov80eddvrbkG5+hB2IRqssejOihwv7uDDjWmkNHeRV+ovOeXbzkDSIEpIlypRZPe8U9DWeAHNv0++PXxstZOkWAUK/HKjLgK3xJSJ1b5NCZ7HRWGvkDhJr+XEu0g3v5VFn7qrc4MJF6hYy6V1kQpjDGeJpggHDjzSoD4KWqhtP0BRhE6+2utm4j1M35PC8snsUKM9zY6wAyeC68Aaf5cBUlnTvFChdqs9jVvfAOb8oJPYGV8GiDx3x+6F+PLklet1XH9UGDWVLH91T03JtT+ampY6rkSQlJl5MSqdAumVpIQAEGBW9UCd4e+kTF4w9Lnfecd9GaWKCB4LbEnqrfEmJOFQC6BdLCfzqgO2bFfenG9IebQd7NPeuDEehJtAHy7hH0jO99Jfy+TpEBe74soo+H
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(316002)(52536014)(8936002)(8676002)(4326008)(478600001)(966005)(86362001)(5660300002)(41300700001)(33656002)(4744005)(2906002)(71200400001)(122000001)(38100700002)(26005)(7696005)(6506007)(9686003)(83380400001)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QzVkam1qVGZNTkVnWllZb2ZNYXpoK0lWeUg1UXhTdmpEbDhOeUlocXlF?=
 =?iso-2022-jp?B?NldldnRWeEhnNlJrRFB2ZmJlajZ1QkRpWFdQaDNtVHFtbVJNOUNqcVVp?=
 =?iso-2022-jp?B?UEdGV3dSNWVGdC95YzBZOHVpTCt6QXpDdUtOTjFsbGlYTDlKeFp4cXVr?=
 =?iso-2022-jp?B?UklqOVNuZmJncnc4SHczN2JMMUtDTmIzYkk4VEg1UDExVVJFWkR4cU5C?=
 =?iso-2022-jp?B?V203TERGN0tGTW0vblMybmlLdFh6RGhRb1dCRThvVEVzOTZrSkdSRUQ5?=
 =?iso-2022-jp?B?ai8rUlJDU3k2R0FVby9ycFpkZnVHVERSY2ZoWlk5aDNodTZFcW1HNjRa?=
 =?iso-2022-jp?B?b3RkS0ZQSk9ESFZOTnExSG9CMGx2cG80S2FBS2RsMjYvazg3Q2dRaUJH?=
 =?iso-2022-jp?B?bUF6MTlaeDNMRGNvSEt1dkVMa3BWRkRkNHRZVkJXMi9hMUpKbjA0QW9B?=
 =?iso-2022-jp?B?WHFUZmpJa3dDZy83M3ZZeEU1ZDBPWG92VmRZQWJxbzZONEM3SUhjSGlF?=
 =?iso-2022-jp?B?V0h0M1NXQ2gzT0kzT0V2TlN3RCsxQ3I0V0tNYmxVNFl6OWJLVFU1UTJW?=
 =?iso-2022-jp?B?dkJZR0ZXVkZYb1Q2MmtJYTlKK2xIRGNnVi9RWGxYMUdwN3ptVm9MQWc0?=
 =?iso-2022-jp?B?S3dOSkE0WkZqUGppUTJubXN5Yk96b1grK2pZVFVxZmpHN3lJV25LMXJT?=
 =?iso-2022-jp?B?MmxGU1lrRmJtTnNrWlFhblNqZXIyOUREMVFYTXF5eSszT2pFdU1JRzFj?=
 =?iso-2022-jp?B?SWROZkJmcTU2R1MzOGRZQk5IL3BKNzByVy8vZHY2UUtLdFZwdCtLY0g0?=
 =?iso-2022-jp?B?c2xqT0hrdlFBcDZDdUJYYTg3dmNpQnhGZVJHYUZIZ3VQeVBSUWZGNWcr?=
 =?iso-2022-jp?B?dVovYVJUSlZaa0Zac2NsSmEyTlgxVnJYUTliak5VbFNxTlpDYUlKS1Vu?=
 =?iso-2022-jp?B?THpBRzNjZnZ1MkkyZzArVnBtNGhrQ1V3QnUycHNoTHRvb05LdndvR0U1?=
 =?iso-2022-jp?B?dTd1UVVZWjlYSTlXNVNrQzBzWGwybkFBZzZzdDBWUW9QeTg1a1RMVzlL?=
 =?iso-2022-jp?B?cS9qNG0xOExwS1lJazlYa0FDQzhmZEVpZHh5elpEbmhYai9FT3ZkQVZT?=
 =?iso-2022-jp?B?T1hyYlAyQWFCWUpRVmhtOVN5SHQzUjFuSGxRckdLTkx4R3dZMjJ5VzFZ?=
 =?iso-2022-jp?B?UEVKUmpiL0pZQ00yOTB1YWpRQnRpRUNtak9Qd1BRVDlNY1ZwczVyWXdo?=
 =?iso-2022-jp?B?dTZoL3Fpc2NzYWYxUG5WSDYwR1dVaDlickg2Z1M1S2o3NkZJa1VsbitC?=
 =?iso-2022-jp?B?NTZnZ3dYaU02YTNhK0NFTFBoR3hMSTcyM1VLNThCTWMzS2d5V2I3UDRM?=
 =?iso-2022-jp?B?c05XVmZEU2Vkb3U2TnZqVU1GSFBWbnVYOG40WlhMRWxVVG0wbFo2RGtP?=
 =?iso-2022-jp?B?UFVCVHlCSHJvbXNCRGJ6ajJoTFBIZExzM3MweXdVZVc2YTdYTGF4R2x5?=
 =?iso-2022-jp?B?NDc1QWM4SlBkQkV1WFhGMEtlbStVZDBhVm1qWVFnYmY4WllibXhOUXE3?=
 =?iso-2022-jp?B?M2NuTHpNYnlkQU1XVDdkZUxGZVpzWlBzM0xDWUFzSjlJam4zNDVMSG91?=
 =?iso-2022-jp?B?MkhQUkhtR2dYTUxxMzcyYjdsVjhUK1VuSExablhiZ2FMRThnOGw0a1d0?=
 =?iso-2022-jp?B?eDFMalg5MENoQ2FRWWNXSDJpR2dBL0lpS1NNbEZONUZycGtJYzFYT29D?=
 =?iso-2022-jp?B?aXdLMzJGdksvbWtORUIwbXFZRkhyOWkrYVlyS1U0cmhEam1FaGYrL2NH?=
 =?iso-2022-jp?B?dFVVMXhjaXphR1Jnd3VxbmtCeHZvcUxBNlBxTURtTkdMT0ltME1JYWhQ?=
 =?iso-2022-jp?B?OVVSTlp4Tm5taitFRlNPWkphNmFMZG5Lcjg3Z3pXc1pLdWI4WDJoYU9n?=
 =?iso-2022-jp?B?RkNlTnA1dnVnWEdMaC9oUG9kZllSVG1UMmNTczM4TmtBd0J4aWo1MTNC?=
 =?iso-2022-jp?B?MTBCTWFWQWNKYTlTak9iK2JoRXI2RmVZZnNXbG1mNzJYS3hCbnlycFNv?=
 =?iso-2022-jp?B?UFNkaHFOYU45Vi92Y2ppdXFrMlg1ZFRPUGRzaHVrclVGNWRqOElLSXMw?=
 =?iso-2022-jp?B?MVN0dlJHTEhnRFVUTHIzdWJBZVJCR25BRGZuL3hhZnl4Y01DKzVkM1dS?=
 =?iso-2022-jp?B?ZkZlbGxxWW1OV3Z4Y3c3WlJUa1hMU3A5QnAvQXZCSDZQNzFIYXdzTmp1?=
 =?iso-2022-jp?B?NkFsUkFTNmMwMlB3MCtmcnQ1cGRjdkh0bDkzaGkzSHVNZUJkNXR0Z3hw?=
 =?iso-2022-jp?B?SkFUTGdXYVlBMmF3NXZwUTU5OGhmbUlrakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce7f3ee-a271-4d3b-f538-08dbec1f1dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 12:24:19.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WewzhCPRcBptxCczpvqT1r7mNmZIzeXYl86sL8SlnxP05EXSJI8XZFCc62/HWGRGf7DVypWShM+sXi6YgnHUkfwytvCjzg3l4taGyT1Pw6HBnMQ2QwgKwMg1huXuSe4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9691
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:24:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13665

Hi all,

CIP kernel team has released Linux kernel v5.10.201-cip41.
The linux-5.10.y-cip tree has been updated base version from v5.10.200 to v=
5.10.201.
This release is a release for adjusting the cip-rt kernel release.

You can get this release via the git tree at:

  v5.10.201-cip41:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      938020393640bdc81fe4e07756918636afef2917
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip41 after merge from stable

Best regards,
   Nobuhiro


