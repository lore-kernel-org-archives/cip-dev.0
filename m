Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE4C25B76
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 09:30:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.10947.1717579841714112013
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 02:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ZcjqFdM4;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1717579816;x=1718789416;bh=M2
	HPa9R+m09lFiTfBcwmRM+gk78mAAj298uYl26Y2sU=;b=ZcjqFdM4OAaXz30Y1CFZO4sln4fhUCC3
	XBBCLdd8XQOUG/14dMQ/jPS4r3Pi3WNT7rpHknmM1NN7kkq3Shv1aZiG2FCb9dmjm21wKuTGRy/KR
	DOAIB45vfGK7Isz7+vZnA1dm4fvksAVEZUlnhNZO7LjUDLnXBJMzg7sWawCA2VjtfFNK6WGH4Q9hX
	mJegH1X1G8FTlXhZr6CKY5OJmZWy6sYbg1xKwhnBSjJDrhnc/uOVNcZDoMFSh7zy1Ob3S414H9dC1
	m95xeH7r+Ue/SH/VvC5ozW4HbfmQ6X3H0O8OZgrgBhWd05EzJLMaeDOSVmxVXzV43dAD6uvFrhTC7
	ow==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4559UFbj1736322; Wed, 5 Jun 2024 18:30:16 +0900
X-Iguazu-Qid: 2rWhNMNed4hCpFRT9h
X-Iguazu-QSIG: v=2; s=0; t=1717579815; q=2rWhNMNed4hCpFRT9h; m=w1yG6swEL3UxumCtZnHnXIYtBxPSNhID8XV2J66onNI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4559UC5Q1904942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jun 2024 18:30:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOo/rdDIU2tgVhmjtHiqcXkUC3jPZh5a54Lh2PSDYeVLIIXrvBD5pWZg+zQhH/yRX1JAqXyhBqAK9Jnv9m/FJ/VKpBXV6gK7gMVpcR+RSujMyP83OwF1AeR5VnY8ryKAtQSMVFotrH5qEHxUpYHcLNKI8JTiVk9EYjme+s3wWMGMIlE5O1En322ta3/fXFxhrXhOURiMbpc/GckUosaF6AtMIXvtsCQ3N1WCtY+dAlHRjvbWjRYfaYCd41VwMnRr/1kUscYWCUtIfj3r+ZMUr63eeiMuIFrypO3TTVUr+gVtsv35D9g2kEQk0PWUFvMh6+nH+dMrji89pTShX2L/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thBXer3Lj0w8FvXOdwLKfKsL4KyA/tTyNUpRyX+XirY=;
 b=kP5yES0UakWVgIV/4XbhiPggsqdcXPVm669t4l8Lq3z3g6eZgfXmOAicQFZzQSMUm21xndMkxsipbJ3z07gkuGA4DeRq6Ubh0kfKcf5GTsjy0r3H8aVy6Ceobe9MTIcT2VqavIa6f9ugxJ067rvaWGQEnQATM4psd4mGh69w0uzVfrZquZvRScs+faNXR8LjEnWqMledBgLnA0gFanfv+q06hLYc5KTwIqE1Noe6zUzaj6KxN0C8TelbfaBm0SoKPKQ84pzCUfysNCZuemOTkpGEG8cfCZP5SitBnvrynqelxJ0a36S0L0zagNschkTI9WNfY6jwp+7YZ3u/h+xR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.218-cip48
Thread-Topic: [ANNOUNCE] Release v5.10.218-cip48
Thread-Index: Adq3Kt38H68J8SVPQdCg9CeaDOkvnA==
Date: Wed, 5 Jun 2024 09:30:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB639106D0C6A199E3C84EE59492F92@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OSOPR01MB12443:EE_
x-ms-office365-filtering-correlation-id: dd349936-e0dc-43e4-cb6d-08dc854218b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SzRsbVY2eWZOVUlGYlNCTzlPTW9QT1FuNGxNd1c5L2krS1doYUpnbHpm?=
 =?iso-2022-jp?B?clpESWlqd1NRcW1yUUhWeG5QV0hxeDYyUCtyOXdKOXlrZTBwTThEMS9H?=
 =?iso-2022-jp?B?dU9RcUtBQkZBNWVxMnZJR0RiZmVIWTU5aTU1akJsZU56ejlTZHNMdHow?=
 =?iso-2022-jp?B?LzI2VHhWRXF6ZXZJYXJWVGhIZGgvYmFRWGpWeHNkZ0lkczBxT2ZBcHk2?=
 =?iso-2022-jp?B?c2krTmNjUGwzWVpjUU1Oa3hwK1FuNGRUV21TWVlPODExaVRLOXdwRlBi?=
 =?iso-2022-jp?B?aHRrYWVqUFE4K2M1Rkg1ZjZnT0dnNTEraTE4K0wyS041aGRIeTZybGdR?=
 =?iso-2022-jp?B?U3E5WXN6aEFMd2JlWHBZRmgrQTZ5NS84UG16NWhTWXFUNzk4VitsUnpF?=
 =?iso-2022-jp?B?NnVKTmZJOFRQWWphaFB1d05WdnpGVktNQ1N2c3FuQnBSRXpOc0pxNENi?=
 =?iso-2022-jp?B?U0NEWlB0RGVQY2JMTThEajFqYjl5S2tZZ092dDQ0SmF4YzNaUndGR0Iw?=
 =?iso-2022-jp?B?RTAwUWRGbzhvWUFTd3ZkdjhXbHNQK1J2by93eVRaSm1TVkM3L00xWTBO?=
 =?iso-2022-jp?B?WlJRUXZRcFpPNEZSQmtTQy9ESnAyNnVhTzdJQmFITkttZUkrRXVOWXdN?=
 =?iso-2022-jp?B?SzNjbU4yaFAwTHdjVDVkTFBvbU82QWV4VjAvUjJMMkRXQUdJbTZLSTF3?=
 =?iso-2022-jp?B?M01lS2xVbjJpRGphNlc4VmhrQXI0UWxzN3lYdEtBNWUvOGhqLzZyaE93?=
 =?iso-2022-jp?B?OHBhYVdhQjRPN3dPN3VGdzFIMGhBcmZTWkdlVGxKOWp1bEhtU25BL0E1?=
 =?iso-2022-jp?B?aFZBVmF1bUZMdVIxbFdtSStqOHNSajRRbGs2ZTBuYnpYUWdyWHF1YVc5?=
 =?iso-2022-jp?B?bzZabGM3WCs3OE04T25CV3YxZnlzRy81M29QWnIvUlFET2VqVGtaL1lq?=
 =?iso-2022-jp?B?eENJSFRxZ0VxQnhBTE1zd0FBVWg0ZXpSMVRmdDI4RnNuU1VqQUx1NnVL?=
 =?iso-2022-jp?B?SWxIM3RFTGFleDIxUC9MTGZNSloyWkVGZHNTcC95dFJJN2Fua28zY2M5?=
 =?iso-2022-jp?B?VW5vdmtmQUsraU5ud29rL2VESVExRmowMDIrVDBGNVhiU2U0RS90Ty9C?=
 =?iso-2022-jp?B?VzdzMUE5aWw4Um5yemdheTlvODB3VFdaeVdVcTRwY2c3Q1c1YUFLWUpv?=
 =?iso-2022-jp?B?TmFtVlduT1RYZG1GQzBrQUxVRG1UbEtsUG1IcnBRNFBVTzBJUUVjQjNn?=
 =?iso-2022-jp?B?cG9JbytEM2NxS0VUcllSOWdhOE1VQjkyaFUzNXVIeWlDOWdmNlB5OTRS?=
 =?iso-2022-jp?B?ZElCV3YwVE5DNEJzK09GeFAzaDNTZW01MWl2VWdrZEpvV0poZjFWNlht?=
 =?iso-2022-jp?B?cklnaVJLTm5LTGFMM3lENzM0dnZQT2E3eVBRbUlyUCtFa09YbmJIWmNZ?=
 =?iso-2022-jp?B?TDR1YzQ2dUxVNHJoMC9yYXh1T2ZDay9WUW9wekNqRytoWk5UOFNUUHp0?=
 =?iso-2022-jp?B?aVFOWTBFMGZ5V1ZlVHFPY0ljV3d0Z0FHaExPTytUVzhVWjVOdDJKbHdJ?=
 =?iso-2022-jp?B?VUZCU0ZFMkNOTER4MjNhV1RYRWlZV1RWT1RGZlRZa0lSdWhkK2NxU3RT?=
 =?iso-2022-jp?B?eUJwMHhNdTR3MklpR2pxSTBoVUJCYnQ3dEllSFJJaEhlNDB0OVA4dERn?=
 =?iso-2022-jp?B?QnlEZDNYS214NnBESVppK3Zxb1prendwV1BlRXNHelQyQlJlenNIdzBR?=
 =?iso-2022-jp?B?cThSRUpkbVNHczY0YTZ1NnUvcllOc0VBbFZhcUxldDdvL1B1Ky9JUUw0?=
 =?iso-2022-jp?B?TUxRd3lnWDBUY1U2N0o3WjlzMHd5a0tNZFlPMXFZSGNDY1huamVMUUZp?=
 =?iso-2022-jp?B?WGpVVVJxUGUvaXhGWUlUVnk1My9ENC9vNmV4WG1nRnMrOHV1aDMxamJN?=
 =?iso-2022-jp?B?SDJreUd3M2QrVTJNbVAyUTZycm1uK0YrUjduL2hUS0l2OFNkdmlpeDVH?=
 =?iso-2022-jp?B?SWs0ZG5MS0IxQUl2UWMzWFhVVDBHc2hQb20xanF5cUJlaTE0eTUxQzlK?=
 =?iso-2022-jp?B?U1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RHlvbGR6eUEyMnFNNXB0L2dqa3cyQmNlaGVQVUF3MDkxRkFISGhPbjVh?=
 =?iso-2022-jp?B?ODYrdDlNNW1sZk1zZ0tuR3JFam1jb29Ec1NVV1BJeEphZ3cvenIzWm5r?=
 =?iso-2022-jp?B?V2piQXhaQkJmRlVLb2FjWnV2VXZWb2pkV1hSTmFwYXpFeFJJSGtjUUJ0?=
 =?iso-2022-jp?B?Q0pmOTc5QkJ2Um1xaVBHazdWNGJocmt1OG9aNElHQVBjckYraFR4NSs1?=
 =?iso-2022-jp?B?Ykx2OHIxeG05R2FIVnYzODhTL3h0cHRqa2ZaM1Q1TGxPTGxZOWNYeEEv?=
 =?iso-2022-jp?B?TlhPNGgzVmJaOHFrdURDYnNXL25EVFA1STI0SFpaVGJuV2pWNkdBd3Vr?=
 =?iso-2022-jp?B?M2VKTUQ2U3lrVk9wOGVmVStsU2Fra3BmWlMxcUdkYi9jMnIzamxDWmFo?=
 =?iso-2022-jp?B?Q0VMRWRqRlZSd0x6NmpKUWgwdyt0cWF4ZEQ4NUxFanRUelY4N2dNWUVV?=
 =?iso-2022-jp?B?azh5WEVMOElML1MwSm4wb3VRSGF6MnNaeHNjS282NHZrZndrR3JDazA0?=
 =?iso-2022-jp?B?cTFkZGl3dnpaaGdQTmQxdGczRUJidE5hQWFWU28xa2Z6eGpIVkNrU1k5?=
 =?iso-2022-jp?B?dTc4SlE5NFVwa2tyanlsRUhTaUxJUVNLT2FkWU5STVRjbFREWmRFelor?=
 =?iso-2022-jp?B?VXNLd1B0UVhocGRCWERMS2JFSmZoTjFnVjhEcjJwcTBaNkg1ZVd0eDhu?=
 =?iso-2022-jp?B?VXowTUVpK1lESUtXRWFTVEh3YXJWTStQNWZKdFhhdmRRSzhmN1lSM0RF?=
 =?iso-2022-jp?B?ZllRMkc3cUxGRG5PWldmdFRyQVlBbDZpMnF0ZmpKY3VOeVdnNWRsdmsw?=
 =?iso-2022-jp?B?d01rUlFVdEtQS0NBdFR3K2xocXROSkVVQTRWYnFYNitsU3J2aklHSjZF?=
 =?iso-2022-jp?B?ZFJRMHV3SjBTQnZnQnpFQVNMVDdxTlU2NEZyZnpTSGo5bU9kMmVxQ2Rx?=
 =?iso-2022-jp?B?ZHlhY2pKSDZWN0doeFZRMEIzMzFyNFgrSXY0ZkpubjYwVTRFaEp6cmZD?=
 =?iso-2022-jp?B?Y3I1dGYxL2RtbkNZVHhjTjY0bmJDQ2I3bVg3cE9pdDlLS1hWeTRYVG55?=
 =?iso-2022-jp?B?UnllRjQ0bjJ5YkNIaXM3RktNNHBKNHV3anhKdFZxRnFLRVlwWGpnKzFt?=
 =?iso-2022-jp?B?QUhqQ0loR2pOelhVeXJ0a0tmbWxaNmtrdk9zdWJZaU8vQk9hUmI4TUov?=
 =?iso-2022-jp?B?L09JTThmcWtqVyt6bHR5Yk5EdHJiMDFSWmgzd1FvM3h0V3o0SEI2Y3VH?=
 =?iso-2022-jp?B?Ui9qQUFnTjVtekJFYzFDMXRRZ0dpbUhoak03RmEvbkVxK0RVRXJLRllz?=
 =?iso-2022-jp?B?WGQ1clFqK2orbjdtcmVWV2duNWw5UHBEZWRXZ3RpNllQRnErT21GRGdW?=
 =?iso-2022-jp?B?Ync4Nkx2aVJ5OGtyL0ZDZVpCVE5hekk1SldrOFJvY0lyTWFtayszZk50?=
 =?iso-2022-jp?B?cUdXUHdoOTQvcDRISXF2TTNGSEdwVTZTRm1aaHZCT3VOdXk3d0VyWlds?=
 =?iso-2022-jp?B?N2EwQXdSYVExK1ZjVlM4azVCaWVMQ1pOUlM2N0QwL0hYcnN4M0w2MStX?=
 =?iso-2022-jp?B?cnlDQXNZVElLbDNVRjRSTSs5bnZZNGVhZ0IzZ0lUVE15eFM2Mkl4NU0r?=
 =?iso-2022-jp?B?UkRqWHNOS0dib1NGbzJiWFpUcVRpQzVzbXVDYTgyVVZYSm43VmtFcFdG?=
 =?iso-2022-jp?B?UXB2QmlGQVlIWnBEVjIxeFhiVFNQbkVVcHFOU3AvL0ltQmlhUUhoL2lx?=
 =?iso-2022-jp?B?bmkxcEJoY3RsbXVhekRDYjlsSjRLb21YVlRKOG5BbVRhSVBpR0tqMlNR?=
 =?iso-2022-jp?B?cnM5N2ZqU1JzTEV4bzFVQnU5VHFtMG01VTNrUXcwd2p4bi9WK3BmZFJD?=
 =?iso-2022-jp?B?S0s1cnBUckFsamF4bEdnTjBrUWhSc2ZkQ0ZrdHV1dVZrYUdDaFc0VC9F?=
 =?iso-2022-jp?B?Q1VodGs3bWplbzNUaEd5Y01MVkozTFhzWGVCUGFJbmgvOHhlZU1Pc3VH?=
 =?iso-2022-jp?B?Q283eGFVSDNKYUhHV2VnR0ZtaUxPS1g3MGpid3Y2cVNZY1lYcUkwNWFa?=
 =?iso-2022-jp?B?VmpuMDNyZ3ExcGNQUWlWdUJ0Y2labWtHUFhubmY5YTZ4WDBHejhWU29z?=
 =?iso-2022-jp?B?SWQyRzdSbmM1a2ZSdS9Ib0lPL3FYY1daQjR0L2oxcDlibktKSFNNQnRP?=
 =?iso-2022-jp?B?RUN6MTJlMXk2V1dPZnk2Ukh4SWZ5WFk2Q1d4L2czK0dvQ1R2b1B4WVJl?=
 =?iso-2022-jp?B?OE85WEtMazh2aHZ6VjFCU3BvQkRGc0dFTytGaysrL1B2VjFTNGlQS2Uv?=
 =?iso-2022-jp?B?cTNnWEdZSlBxTDRxeGNORHdpa2s3VThjdlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd349936-e0dc-43e4-cb6d-08dc854218b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 09:30:10.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU3npEHRmGFQNEwTYa8s6TVMXZ3ZAEQYtR/C26mvpgevr3TzLoXSeB/d0TIIPnRHMvEp2k5bipglTlg9ePUrxAUSiLlU3JGK7WwU+bVwdIWePsc0GOi0aNkn9ClwlJ9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12443
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 09:30:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16112

Hi all,

CIP kernel team has released Linux kernel v5.10.218-cip48.
The linux-5.10.y-cip tree has been updated base version from v5.10.216 to
v5.10.218. In this update, an Ethernet device (RAVB) of Renesas Arm SoC has=
 been added.

You can get this release via the git tree at:

  v5.10.218-cip48:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      3f09343b0c3f3883ee5633f296af305609b12419
    Fixed CVEs:
      CVE-2024-35947: dyndbg: fix old BUG_ON in >control parser
      CVE-2024-36946: phonet: fix rtm_phonet_notify() skb allocation
      CVE-2024-36017: rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute=
 validation
      CVE-2024-26900: md: fix kmemleak of rdev->serial
      CVE-2024-27398: Bluetooth: Fix use-after-free bugs caused by sco_sock=
_timeout
      CVE-2024-36933: nsh: Restore skb->{protocol,data,mac_header} for oute=
r header in nsh_gso_segment().
      CVE-2024-35848: eeprom: at24: fix memory corruption race condition
      CVE-2024-36957: octeontx2-af: avoid off-by-one read from userspace
      CVE-2024-36950: firewire: ohci: mask bus reset interrupts between ISR=
 and bottom half
      CVE-2024-36929: net: core: reject skb_copy(_expand) for fraglist GSO =
skbs
      CVE-2024-36883: net: fix out-of-bounds access in ops_init
      CVE-2024-36953: KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_=
v2_parse_attr()
      CVE-2024-36934: bna: ensure the copied buf is NUL terminated
      CVE-2024-36886: tipc: fix UAF in error path
      CVE-2024-36964: fs/9p: only translate RWX permissions for plain 9P200=
0
      CVE-2024-36940: pinctrl: core: delete incorrect free in pinctrl_enabl=
e()
      CVE-2023-52882: clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate=
 change
      CVE-2024-36959: pinctrl: devicetree: fix refcount leak in pinctrl_dt_=
to_map()
      CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_ti=
meout
      CVE-2024-36907: SUNRPC: add a missing rpc_stat for TCP TLS
      CVE-2024-36919: scsi: bnx2fc: Remove spin_lock_bh while releasing res=
ources after upload
      CVE-2024-36905: tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV s=
ockets
      CVE-2024-27401: firewire: nosy: ensure user_length is taken into acco=
unt when fetching packet contents
      CVE-2024-36954: tipc: fix a possible memleak in tipc_buf_append
      CVE-2024-36939: nfs: Handle error of rpc_proc_register() in nfs_net_i=
nit().
      CVE-2024-36904: tcp: Use refcount_inc_not_zero() in tcp_twsk_unique()=
.
      CVE-2024-36941: wifi: nl80211: don't free NULL coalescing rule
      CVE-2024-36960: drm/vmwgfx: Fix invalid reads in fence signaled event=
s
      CVE-2024-36031: keys: Fix overwrite of key expiration on instantiatio=
n
      CVE-2024-36902: ipv6: fib6_rules: avoid possible NULL dereference in =
fib6_rule_action()
      CVE-2024-36916: blk-iocost: avoid out of bounds shift
      CVE-2023-52585: drm/amdgpu: Fix possible NULL dereference in amdgpu_r=
as_query_error_status_helper()
      CVE-2024-36889: mptcp: ensure snd_nxt is properly initialized on conn=
ect
      CVE-2022-48655: firmware: arm_scmi: Harden accesses to the reset doma=
ins
    added commits:
      CIP: Bump version suffix to -cip48 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
      arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
      arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to select o=
n-board functionalities
      arm64: dts: renesas: r9a08g045: Add Ethernet nodes
      net: ravb: Fix registered interrupt names
      net: ravb: Fix RX byte accounting for jumbo packets
      net: ravb: Fix GbEth jumbo packet RX checksum handling
      net: ravb: Add runtime PM support
      net: ravb: Do not apply features to hardware if the interface is down
      net: ravb: Move the update of ndev->features to ravb_set_features()
      net: ravb: Return cached statistics if the interface is down
      net: ravb: Keep the reverse order of operations in ravb_close()
      net: ravb: Get rid of the temporary variable irq
      ravb: Add Tx checksum offload support for GbEth
      ravb: Add Rx checksum offload support for GbEth
      net: ravb: Simplify ravb_resume()
      net: ravb: Simplify ravb_suspend()
      net: ravb: Set config mode in ndo_open and reset mode in ndo_close
      net: ravb: Move PTP initialization in the driver's ndo_open API for c=
cc_gac platorms
      net: ravb: Move DBAT configuration to the driver's ndo_open API
      net: ravb: Move delay mode set in the driver's ndo_open API
      net: ravb: Split GTI computation and set operations
      net: ravb: Move getting/requesting IRQs in the probe() method
      net: ravb: Move reference clock enable/disable on runtime PM APIs
      net: ravb: Assert/de-assert reset on suspend/resume
      net: ravb: Make reset controller support mandatory
      net: ravb: Rely on PM domain to enable gptp_clk
      net: ravb: Let IP-specific receive function to interrogate descriptor=
s
      dt-bindings: net: renesas,etheravb: Document RZ/G3S support
      ravb: Use GFP_KERNEL instead of GFP_ATOMIC when possible
      ravb: ravb_close() always returns 0
      ethernet: renesas: Use div64_ul instead of do_div
      net: ravb: Count packets instead of descriptors in GbEth RX path
      net: ravb: Wait for operating mode to be applied
      net: ravb: Keep reverse order of operations in ravb_remove()
      net: ravb: Stop DMA in case of failures on ravb_open()
      net: ravb: Make write access to CXR35 first before accessing other EM=
AC registers
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Fix lack of register setting after system resumed for Gen3
      ravb: Fix potential use-after-free in ravb_rx_gbeth()
      pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
      pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
      pinctrl: renesas: rzg2l: Add output enable support
      pinctrl: renesas: rzg2l: Add support to select power source for Ether=
net pins
      pinctrl: renesas: rzg2l: Add pin configuration support for pinmux gro=
ups
      pinctrl: renesas: rzg2l: Move arg and index in the main function bloc=
k
      clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH=
1

Best regards,
   Nobuhiro



