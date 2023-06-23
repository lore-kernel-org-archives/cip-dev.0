Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78BEB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 10:53:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.39286.1687517577605884799
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 03:52:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 35NAqYRK015334; Fri, 23 Jun 2023 19:52:35 +0900
X-Iguazu-Qid: 2wHHvlq335wxKi4Lmi
X-Iguazu-QSIG: v=2; s=0; t=1687517554; q=2wHHvlq335wxKi4Lmi; m=AZSoVaW4uw3zhcly3CzAQ1pYvupua9BE9bnoaIULN3g=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 35NAqWhm004346
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Jun 2023 19:52:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnQxCosNP541nx+HJ/Obqgiu2JFyCgk5frVbCbyqk/MFjBl+qJ9RBC8Hw73HIViox6RBjxhFbQmDhB4dD7nR1ljfjRhosWf0OkOsfrKewoHyGp+2mveUcPKx+gbj6R9dN5s4iGTp+BuQerAeTGr2KzxR0Wc/dX1N0zb4xcSS4BJy7mok2BW1mRjR6L2P27EOLWJSttCB+j5aCqJNtPO7EDUfwc1KXPEtDeyMYwNlLwoDvfsPQlTkXbn32t3riwqFjufVUjrpY/PquK36H7eenWsHpIFYL1IH/rbucyWKrzk7Bp2rBRT3qvlCZ7ZBjGFwZP1s6oM9XcPtR1fHQ25Htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smw9NQJZt/lg4MLRZNspvBZVRVr7UUywRmcGu4bQkas=;
 b=YlUSBr93bSfJZ5uhvlxaOLam3YOSyWX/tHaLbqJmtTC8KjgZpCWtGBcAyMuggZ2Ep38zfUh0ARse+Hng2jURlKuJZhhQMewU1Wct/qaaa3AcRACmGj5vaexmCvfdWvMJfGP1rxxm5/mMHR6ZH4NWAJtKi0T/dYYFIrHpgTVQbYlPqC/WhslKjz1Kl0l9aeEm13l4EKgrscyYmIjR6jrwIW/p0pvCUUAT12OaTUnPgM87kcj+y1hfwPJYSyTgVU23Vv7iPkZlg8LxBQ9esNImlloqRvnZXnXBtNs+onKHHMU6AMdSjTTXAS6fw5Ff5ZTHpVXCsZecydZvECCpwdTdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.287-cip100
Thread-Topic: [ANNOUNCE] Release v4.19.287-cip100
Thread-Index: AdmlwK9ZsVpueO2ZSXCWJkztQHPurg==
Date: Fri, 23 Jun 2023 10:52:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200ED696BBC57ABB9B52409223A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11904:EE_
x-ms-office365-filtering-correlation-id: bb01dfe9-8a59-4c7f-a5d4-08db73d7f0b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rB9W28zdieyNiEt/VWQPSG5GTupsjp3dwG5ZeJLtzftVWHH5NBO1GBsvESQPG2ra2iK9OgomxGFIEhqmMWBaSvRLkAzy5Vm8a5j7D+G8TXighIV2Qj8tYB4bTSNsr2MIowOZK+VAMc8DED0HiM8VpwhaQSljGHPRKgzfVMTTsNSKLSsOVX1x2D4PjtrL9javOuNW6kBlUj2bGRNlLsh0PSMIGBD7AA7SM6fp5ZMO6Y00VgrIfaJDt5wzWUmS0RquWPDpDjCYp3r2BziZKh8kUhTQEryicBGypQDWghG827TC2T+5xnwu56MYcQ9kyCR5CrouBUkgOnlPt5HselD1vHZSOkfGVhSjbQkb30AEUuaoi8FGr4fjEuwAtgaxAzgAfj01c6xV2EU/CQS29IbXARBEObioSCEWf6Fz/SKAYtri0Sxbpq2fwQ7vKA5rG/JTEPt1Uue+9mvKes3eUbccbz6462PG4rKxO6F7uIJY+98ecvyniU/P1d45B+8pnSrrmYoEsuZbczsgPpG+BBUWFri6/eNuli5d5VTdxzZQfK7JXVNHAu4A61j04ASZ3CLl5wZdyEIsp5TKpdb7cogo8LIlVzW0xA3Lf1UIQVlyJsN+2w/ceUy6Umj5gIlwgNtYfztd2E9ST3qxgZpcAW0mZw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(4326008)(316002)(6916009)(86362001)(8936002)(8676002)(76116006)(66946007)(52536014)(66476007)(66556008)(41300700001)(64756008)(66446008)(26005)(71200400001)(54906003)(5660300002)(9686003)(186003)(6506007)(83380400001)(478600001)(966005)(7696005)(55016003)(33656002)(2906002)(4744005)(122000001)(38100700002)(38070700005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OVE2eVdCN3AxUWJaUXh6OUNsR2RTZVJaOWdhYXZjNFNUZCtYTE1qTXRy?=
 =?iso-2022-jp?B?Z3lSVGVPRGtaUnUwQ2tMWWIrc3JsRlZ6VlhOeUpjeHBTdE42U2t5dU5D?=
 =?iso-2022-jp?B?dG1GNmVaLzI0bm92MzlqYjRxTGNaaVd3dkt5Z2VXMmdoc2JyRjl1aUk0?=
 =?iso-2022-jp?B?cG94NEQyQzFxRzBwMXdNU00rVkNBQkFHa0NKVW9FOFAvSlBKZm0zeXAr?=
 =?iso-2022-jp?B?UUlPRHFwSVcvK2J5U21jMVhIL3B6VFA2ZldoSHFNUmR6ZGNCS2t4RmxM?=
 =?iso-2022-jp?B?QTczUEpXS2MzRXRsQ0ptZnhObnNERXhDVFUvUmV3bDhQRUVJd01ZWmdQ?=
 =?iso-2022-jp?B?U0NHS1ZSckVBQlNjS3BBSWRPY3JuUEN6L093Q3FqWlhmaDBXWDBydmZN?=
 =?iso-2022-jp?B?R3BQcHRIaUo5N2Y0VW5ORWNja0Nqa1hrYSt2WFpDZWtRdVVJNXlIUjlZ?=
 =?iso-2022-jp?B?T3c5a0dmQ2lGWml0TFBKTXRYa09rV3ZiWGRER2l3ZGg0ZUhXSm1ick5Q?=
 =?iso-2022-jp?B?VURGS3FLWHM1T05vQmRTeWJ6c1NYNjBYREhBNi9JdWRBdTJXaHd4LzJ3?=
 =?iso-2022-jp?B?REFzL1NhL0J5TFJ3VmNFM202OTZZT3F1RVBGeWRjQjA1VGl4VWdsWm9K?=
 =?iso-2022-jp?B?UGhLSDN3WXdLT3d3R3JPSUd6ZFNqYTR1dlJCMVVTMzdlWUg5L0dhbUIy?=
 =?iso-2022-jp?B?WXRCRlVYaDk1bkQ5OFgzMkhlYjlXZ3BVWVFUTjNzU2ZUVnl0T0EvckIz?=
 =?iso-2022-jp?B?MHFwd3NWRm0rMGNWN2owamdXKzlmazNBckRkVHdZdEphRjZrKytScVBC?=
 =?iso-2022-jp?B?Y1lMekpKb3RkWW9WZGp1MkZKamtvZnNodU4vTjR1REEveHpuSGFRdkEv?=
 =?iso-2022-jp?B?cjl3UlZ3MHMrV2hWK0drb0w3bmZLRFFXUW1oazlPQjFFUVUvajY2SHVt?=
 =?iso-2022-jp?B?Q1g2czI5WEJNVlFwWFhKNFdwUlpYU01QN1M4ZHp5N3N6WC9mSmVmMTdz?=
 =?iso-2022-jp?B?ajZtMWxpdm11VGxYaHU2ZVN6STE1UDJ4SlZZK0NZdXN5QjVzc256U24v?=
 =?iso-2022-jp?B?NjdrTjJwTUFXQVVPdE5rN0tYaFlvNHBlZXNtbXdNc0V4K0UwUXgzN3lZ?=
 =?iso-2022-jp?B?L0E0R0lhMmU0QXd6S1lCNWwzZXo1eGw1cnphNjRRMXB4c01Bei9HQ1VH?=
 =?iso-2022-jp?B?dmZTaGpGL09JTHV4cjZjQWRvdlRiMVdOcWJKdVJwb0tHQzZ4N2lLRCtC?=
 =?iso-2022-jp?B?MmovOTNUZ3VXZVNTZXhmd2xIaHBVWXpQSTVITCtVdEU3bE1aUE5MQzU2?=
 =?iso-2022-jp?B?S0pzbWQxSXQ1UTN2d294ZnN0U0pscFc2SGU0TUkvcytLcDgzM2FpMVo3?=
 =?iso-2022-jp?B?QXFQV0FvMEVpbmNJMFhRLzhuU3hqTjliaTBON0VzdXlMbWN1UFhBQyty?=
 =?iso-2022-jp?B?dit3QmFDYmYxdlFaYlFTNXZMK09vZndIM0N3Nlg4SEpDOGpxNkZmeW5U?=
 =?iso-2022-jp?B?S0NyMlJCcFpRV0g1S25TdmQzNHlMUWkza0NxZmpJM2JYemVqaDV2YXFL?=
 =?iso-2022-jp?B?cGcrMDFlN0FUL1JwZCtZdGNzTXJhQXdFMEJtVHYvOGoxbnpJaUlRRUtF?=
 =?iso-2022-jp?B?ZHlDa0wzNVVwNWtRdHNhUkN0L0M2M3AxTG9KMVdpZTNEM3BkR2hpTHdH?=
 =?iso-2022-jp?B?cjlYNktiV3JlcHNxN09GVFViZ2hJdFlrZ2F0Rm8zOWV6WUJZTGhUUVpV?=
 =?iso-2022-jp?B?ZjNLN1VCMVJaamZQb2d1MlhmcmdmbThhMW9LNnBaSTcxVlNqdjQvR1Va?=
 =?iso-2022-jp?B?Z1lsOENZRDhqc2lYMGNqQkhHTGVqUlVwSjFEbE00d2FVSW9ZNDBYbkdD?=
 =?iso-2022-jp?B?NlVGSkxNNlJpdDFmVm5PS1hVMjd3MHJIUU5YMDJnODVtWVYyK0tOWThW?=
 =?iso-2022-jp?B?aXVLcWJ6VjlmWktaNy9HS3Q4c21xRGw2akIvZjFxemJscmlONXhJWXFz?=
 =?iso-2022-jp?B?cXRyYm1QT05aUVFLVDlDenQ4SmtVOVBEOHhLZnpRRjZrTHRReVd4WXQz?=
 =?iso-2022-jp?B?VkNEcFM2ZDgycUFrNzZadzdFNzNXQUYvNDdUeURoMWZPS2tMQmhiaWRq?=
 =?iso-2022-jp?B?ajJ0U280TFJLTjdNTFRTVjl0bk5QYXBnbnA0TmVoVkpYRUdFK3Z6YUZ1?=
 =?iso-2022-jp?B?bzJSYWt4eGRhUHc1RHFiY25Jb3BEbDd6TUtpaUszS3NsbDRoQkhkYWxO?=
 =?iso-2022-jp?B?dlI4QUtMTEV3NUxKVFJnck1jTktyWlpSNTYveWFSQ0Z1MXltbXU3ampy?=
 =?iso-2022-jp?B?Z2hYZk9XUmlKanVTc3JSQWVXNGZ4QWlxZmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?RTh2d1QzYWxLQjhqK2ZSWFByUlIvemNDeUJ3cVd0Z1MvQXRKWnN0eHNH?=
 =?iso-2022-jp?B?RzZPbUQwVmdEazl2eVZpclRPeFZLYjF2NHlxbExMcDJZWE4zVnhTbCtl?=
 =?iso-2022-jp?B?V0FzWHVHbTFCSjhqOTVJQzNaTUlBRUZQR1lwOWpHRzN2NjZVQmd0MXQv?=
 =?iso-2022-jp?B?cGZiR2xKRGxkMEV5a1Ivb0dvaEpleEQ2dWFDMVd0RWFRNmx4QzlFV0xp?=
 =?iso-2022-jp?B?UEl3ZEllYXMzbC81QWxUODJhNU9NUkNCWkhLcS9CRVAwQWlIbTlrQzJl?=
 =?iso-2022-jp?B?cFJTRWVCYVJMNHhXOTkrclpTNXl3c0hmVDhQRGhUK3dsNUF0VXN0K1Ju?=
 =?iso-2022-jp?B?aitHUUx2Syt5aXdUUkxTemRuWFRyUFRubWFOSWtLcWVWRzF3L2E3UHdO?=
 =?iso-2022-jp?B?RXIwdi93UW9Dbk83b0JEY2NSaVZ0SFViT1VXVjhDbjlkRUFtaTViS3JC?=
 =?iso-2022-jp?B?RUhWaFltenVXN3VzMVBJOGFINys4d2tnT1NxNFU3emFwWisxUXNZTWc4?=
 =?iso-2022-jp?B?NHdyMEhqMzRBU1V3Q3QvUXJwTHl0VXluUGVmZDNpYUJpT2tTaldTVGlI?=
 =?iso-2022-jp?B?enNPZUsrTUdKK0NlMVBYdy9qR05ZdkdnQUFQVmpmbWl5MzhwWWN1Tysy?=
 =?iso-2022-jp?B?UXBBMHl6T2NDdHBtZS85SEZNUHNaYVV5WWFmZ254blhLbEE0d1hSVG1U?=
 =?iso-2022-jp?B?WjdwNHpFNGZuZEJDWmNVaTVEWCtPSTI0dSt4eTdiZHROY1lYdWsvbGZp?=
 =?iso-2022-jp?B?dmtiOW5KOVc4c05oVGF3RDRwUFhwaVV3ZlVWNnV5Q3VaMUgzVEp3bTVy?=
 =?iso-2022-jp?B?aGVpU1F1cTd2cjFRME10VDNFMzZSN1l5aE5XcVBhZDR6WHhuTmZPMnVi?=
 =?iso-2022-jp?B?bEhJMUZXdlNOeFlhTUtRaGlwbUp2MG1IR2I5MXZqckQwRmRjTFNzRDZ1?=
 =?iso-2022-jp?B?NHptbnFJZmJ0U0dORjVRSnhIMUNmczdZb0l1NjUvWjdtUDJ2Tk1PT0dr?=
 =?iso-2022-jp?B?b1krMklyWGJMbHBUOVZ4dXRpckhOd3kwQ0hFTnNjc2d5c0FBcjdQa3hF?=
 =?iso-2022-jp?B?aEtpY0ZBbkV1S2VVa1N5ODhxdDFLQWFTcGFCbllESXoybS9VSzBqdWh6?=
 =?iso-2022-jp?B?b01PZ2l5eHJ4clorbmFDM3RJcGcyRHlGeGQzV2JVTyt2V2J2dlBwcWE4?=
 =?iso-2022-jp?B?U3Jib3hKTVFPdlQvbTFrcnhLVmJGVCtSOHY5T2xZUU1aWS8vZVlGQkRw?=
 =?iso-2022-jp?B?TGt6OFl2Mm9aZUtQc0NhTHlSYk5jeTNRQzk2bFhEbi9IZk9pajRrYzJ4?=
 =?iso-2022-jp?B?WGlEQVZPaWxWanhuMnpDRUNoejJGeGRCTnBURUVxUHp3OEt0QUVidHVo?=
 =?iso-2022-jp?B?aUlnc0pOK3RrZWdneHFBdz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb01dfe9-8a59-4c7f-a5d4-08db73d7f0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 10:52:29.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49FPjNQ2iLRRFPQt8Y0wkvaL894JtEpvXmc0TUDZ+bb0BD5JEMUMdPa0gN3qnWP8P7hV/swbgVev2C7N1domZbSxS9F0KzgB32jtWmAOdPwetIPiDvSvxm42o3Nh/bbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 10:53:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12134

Hi all,

CIP kernel team has released Linux kernel v4.19.287-cip100.
The linux-4.19.y-cip tree has been updated base version from v4.19.284 to v=
4.19.287.
No additional commits of CIP in this version.

You can get this release via the git tree at:

  v4.19.287-cip100:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      843423b3724d762d5593ab9aaeb68ac695871b44
    Fixed CVEs:
      CVE-2023-3111: btrfs: unset reloc control if transaction commit fails=
 in prepare_to_relocate()
      CVE-2023-2007: Linux Kernel DPT I2O Controller Time-Of-Check Time-Of-=
Use Information Disclosure Vulnerability
      CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event
      CVE-2023-35788: net/sched: flower: fix possible OOB write infl_set_ge=
neve_opt()
    added commits:
      CIP: Bump version suffix to -cip100 after merge from stable

Best regards,
   Nobuhiro


