Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B1C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 05:44:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.23877.1750052650832969876
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jun 2025 22:44:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=GZlN1yNz;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750052636;x=1751262236;bh=OE4bAzoW6JX1SK7vVZM6LcaBcGUXZLAILy9s/aO
	gVYI=;b=GZlN1yNzjAgLKfwODh4Es7JigR60oCSn9rjdRjOs6/y9gw6X0kjivIRY2jzrVdN4rWBmW
	bE0gCi9hnZbOy/PGdmv/nV3Y2CvimnbuencMoy/Iu4nL2q+lGQC/mD7eVvwuKnUlW783lv9BawRTk
	yHnlb6gKCkXMnHo5PNbAymfmLsGCFciEgulD2YhLa1+EubrZpp0V2DPRn+rDoMN1TEbsVDibXPhBC
	N2o09Szm6eWRcW/EjDLJ5bgiXE6uUXm2oOjwDD2/QEX9W7BGidLYR2/666tNh4I9TER/ndUQA9zrJ
	cNRH4tuSr/EWcdhSLJzex6qz7uoUki5TZE5XACwPYA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 55G5htUI3140262; Mon, 16 Jun 2025 14:43:55 +0900
X-Iguazu-Qid: 2rWhMjEQLluTgcDRRL
X-Iguazu-QSIG: v=2; s=0; t=1750052635; q=2rWhMjEQLluTgcDRRL; m=WVn4YJY65inbMh/LRgWVlEqLGI1VhtiHVjRu/qKIV3I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55G5hr6A1602344
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:43:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfzwrsQ3JlFVlAk8DrokVqZkGpIiFpaGfD2t5X5zk+gQLXuraYoml2UCdXJPbjrs8/PuHT8QhfL6KptV77qWoP2wuzVc+DDZqbqF1GGJUFxBU9SnARZtZ6K/wm0BsaWUIsy2nfVoyJEagkovhK41amjupZBMStI0WN/mfbuZGuRrmmwKfVeLMo6rFmhNrTkLD+9j4TKRhFlCZaeLWl8mRUSKQzvbalS0X2XxDTjrYxXrcNV2AxSZgjHaKExLSHvrFMqgjVsSTNQxIMI1dHZEeQ3ncnQmDL1s4fXx/rGupLNdn2NYvopX2Bl3in1EEj6PCs3pQ/FNuFmFGsPFadS1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aFk9U8p4+0DKNGU9Ne2KRb0SmdKeJQkk9uhz2RiL1Q=;
 b=CglS0/6HafEtzoXdqgQijSsmQNo6fIjYZXXeo3YbUCCjE1rayoIJDS2k/RKIPi6Od2G2KA9QEPV3GZH7pBYERc0sDmeOq1S1VbMO3j7rzslag+ddFgQSYOucqvxG+QoagZxlVesV5GGaYI9l4ajqIPGsZawpFrb+E4D/ZtIZcQOlT/pg2bjgp+oL9HcKcrSsYgaPUVgCRlx14SVshyMPZvWMgIRsNdyh+mkxt9tE8F6wjud3lUmI1266WD/zptJkQgbn446cBm6ZSkrQAfO71qX0XXRKk+tN/4fKO8HlmIozdFP0nn28jE/RM/GcZY9wohsxhnDCywCGMjhwqI0LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH for 5.10.y-cip 0/1] Fix build on rzg2l-video.c
Thread-Topic: [PATCH for 5.10.y-cip 0/1] Fix build on rzg2l-video.c
Thread-Index: AQHb25Q7UBn/VhH7qESjgYblHRBYzrQC+ZoAgAJQggA=
Date: Mon, 16 Jun 2025 05:43:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189DD64E3EE6B1411CD4569270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <aE28YGyJzn+6kGgW@duo.ucw.cz>
In-Reply-To: <aE28YGyJzn+6kGgW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSRPR01MB11772:EE_
x-ms-office365-filtering-correlation-id: a29259e6-8bf9-4f43-0baa-08ddac98c518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YnZmVGEvbVdMU3padHIvdGVxZWk1dDJKYmhPZytQOVBkY1UvRGx3QXhJ?=
 =?iso-2022-jp?B?VHd4MjZPMHpDYlUwNjR6Z3h0VWJtN2ZwTUhiSDB5Rzg1V2dBU29PMVlN?=
 =?iso-2022-jp?B?eCsrN1pnby9kU3QxNjZacDd6NThoNFN0Zi8xWjArL0lJT2NZWTFEazM0?=
 =?iso-2022-jp?B?c2NYRmxJOXMzY3J4Zmp3ZWpuUi9RbUVxVFJoYVhEZGpOZkxJNG9wLzRI?=
 =?iso-2022-jp?B?Zk83YTJ4YTBxci80b0xHL3RqM2Vzd3dHMkVEMHliaWd2Wm9jYWlNYnEy?=
 =?iso-2022-jp?B?NGV6akdPVDlITmpKNmxsOFoxVzR4eVpjdzg3alE4N0lCVm92OHE0clNS?=
 =?iso-2022-jp?B?azg4ODNhQ0hLeGdaU2h3WHJ1MlVmZXhkYW1FcU5xZ1BqN0RHZ2xxUFlX?=
 =?iso-2022-jp?B?SGc5ck9uZTBoQkhJaDI2dmRMa0FwMzl4bStDZWxMOWpZYW40YXd2dXNx?=
 =?iso-2022-jp?B?akFNeUMzQU1BVHhHZHpacEo4L2Z2aVluNWJpY2ZSanpnVEh4K1lNNmd4?=
 =?iso-2022-jp?B?ZGlWamdOKzMrM2Zub3QyRWNrNzVCb1NCeGhvM0I2SVJCRUhqYU52ZUEz?=
 =?iso-2022-jp?B?dWR0MmNaRTVHd1FrTWEwNmpPR20rTjNZUk03NFZoTS80bkQyNEZCQnll?=
 =?iso-2022-jp?B?NFgycFdrMFRudlVBbzRYS0dFOXFUU3lPeVM3bFdFVDJYRTFDRjUxbFdR?=
 =?iso-2022-jp?B?UFNhZDB5SmhSSDJaRWUzSDRDZFVBazdJWWJOQnhBTHNkcHNEYTl3N2I1?=
 =?iso-2022-jp?B?RXlDYUJrU3B2eStGWEVTRVVIeXdnemhGeXU4ZXdrd3drSkpKUGlvSkNV?=
 =?iso-2022-jp?B?NkdwdkxFVU16UHNCK3lqRk16d2orMFUwOE82WlhuaytVSG1zOXFZUzV5?=
 =?iso-2022-jp?B?bGtlNVcwUlI4RjJaTFkyRWFDeGJ2MzlURVo3T0hoNFZSd1NhOHFvamIz?=
 =?iso-2022-jp?B?eXlnSUhFYjJ4aTdjbGRUb3pmUUNjb29NaTUyODY0dGUvakNVQnN4TGpY?=
 =?iso-2022-jp?B?WDFpbVN0eStYdG1aUmdEY2x5a3U3dDlNQmx4cjI2Q2hIL0lKdG1ERjdG?=
 =?iso-2022-jp?B?TzN3K0VtTGcxcFNwbDA3c3NxcnZiN1VHZnJZM2N2b28yaFEvMmtva0xo?=
 =?iso-2022-jp?B?SmdxZXoxWkMxQmMxYU83QUZEVWpmQmVZZFFDMW0rWVMvS096YkEyeUJa?=
 =?iso-2022-jp?B?YU5aaFV0azJ2cVE1dG83S3RGNm9GWFcvQVhPTloxWnc5YXY4M2JQbFA0?=
 =?iso-2022-jp?B?ZlpNS042and6cjVZSktQN0Yxc0tPVTJKRkpMS2tKSXZ5RXdraS9ONzRk?=
 =?iso-2022-jp?B?TmxTSlRWUEtIQUlGL0RuZkxZRzd6MG9CdUFwT0MzRTJrSVdQWVlFS1lO?=
 =?iso-2022-jp?B?ajRjYjNkaXo2NFV4bVBHQk8rWkM4ZFdkY3BhME1TQk5aZ1RmSFMzSG1v?=
 =?iso-2022-jp?B?bXUvbGpZa0xlajVvYUo0azF6dGQ5ck9pUTVYRFNGam1GTitwZ0tEeC82?=
 =?iso-2022-jp?B?aDBRNllHdWkrQ1dScFBhRlFyR2hTRjR1QVhzYmpIa01DcWRldWs3cTJ3?=
 =?iso-2022-jp?B?cnZ3VGMzclp4QW0ybTNjVDYvZXlPYU9PZmliOEQ5djk1U2FQbC9vZk9j?=
 =?iso-2022-jp?B?aGZzdHVPTDBoNWdwQlB1ZXFGWHVxbUIvTkZDRXk4MFVmOVlKcEw2bnkz?=
 =?iso-2022-jp?B?eW0xWHNrSkRzblFMa3g2WFk5L0dOa3dUOTdrN292UVM1blBEVTJrTnkx?=
 =?iso-2022-jp?B?Z1luTmMxdm5Ub0w1bGV0c21EQ0lZOURsM1JNbTVkekdUYzdIVDQ5ck5q?=
 =?iso-2022-jp?B?RjB3YWQ5K1VCemxHNWNvOFNLUE9qRmw3Y2JMellhMTQ4bHZxWVdZYWtL?=
 =?iso-2022-jp?B?a1ZsMUFnNFlmTlpWdGZ3d0Y2azBmS2NUTTBObVlmL09Vclp3OCtwOHE0?=
 =?iso-2022-jp?B?dW41WWpSRTVDQ2FrVzg3cHZTSm1sZ1VyVGxIcXdnU1I0Y0V0dmErTGlZ?=
 =?iso-2022-jp?B?RDRoVU4rdlBTbW1EYi9SbVg2QnI0T005WEFCVUJkR3FjaXRjQkFpMmNT?=
 =?iso-2022-jp?B?N1I2YkdqUjU3UjZKdHZDbVNZQitveEczSXcvVFh2aVJJYldKYkQ3cnc4?=
 =?iso-2022-jp?B?QW1NaThwOFoxTlg5TUtyWFQrN21rc29RPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TlA5amplcms2eXM1T3gxQzZiMk9BVjdteExqd1ZVK0QyeFlsVEwxd09h?=
 =?iso-2022-jp?B?aXBQTWlyN2JxS043NEY5MjNMRFB1bEx0MFVLTFJCR1VDS1kxUWljak9j?=
 =?iso-2022-jp?B?QUlKcWtZLzFDTjFzQ0lKVG1lbnp2UnNCckpIL3pGZ1JoVUxwZDBDMVBU?=
 =?iso-2022-jp?B?RFFNNXZzL2RVMXMyQWJXcWR0UloyYW5WaFJKUlJYOWIwQ2V1dG1tbmJB?=
 =?iso-2022-jp?B?WU5KYU1xaUtIOHM5N1JseWgvRnJJY2U0aE01bjE1Qi9zT01RVmlqNnFj?=
 =?iso-2022-jp?B?K0MvK1FuOXBDUzlOMTV3TUcxOWRqSFBCTy9vOGUzZHM3QVo0RkJ6QWNO?=
 =?iso-2022-jp?B?MFNpOXNEOWo4bVNCM3l5UFc5d0xwMmNseXhHZ1JsSzNMbE05VUdQN1Bm?=
 =?iso-2022-jp?B?M0xHR0Q1UzhXamF6WmdKaDQ4MzVleG5WRk9ndVE3aml1dlVjTjYydTlU?=
 =?iso-2022-jp?B?QXR6TEpVUWRKaGVrUC9vQzBaU1FPTHhUem1SSTRKVVdDdHBacnl1c2F2?=
 =?iso-2022-jp?B?VmhkUXdiWnNIUmxObDlidWkxNFEra1MrK2huUVJQL3Y3c245eFRNWG9l?=
 =?iso-2022-jp?B?QmxOeWRHZmpiVUtpbWpGRFlKb3ZQci8xU3BtdTdHTnBtVi9aMmZkSXVo?=
 =?iso-2022-jp?B?RTIwM2pPWHBrd1NnUzJ3c3gvWUJReHNTbHRkMXUxajhNMVpMK3g2eTkv?=
 =?iso-2022-jp?B?VkJZVi9zT2psdndXTmkyNFJRTnk2Wlk1R1RUeUx1dzFMci95anVVajF0?=
 =?iso-2022-jp?B?L0hkcXUvUUNDVlk2aTRvcW01RzdGYS9ySm83S3ViS0FrSTJEbnkwcEZS?=
 =?iso-2022-jp?B?WUljZW13UGhmSGFtVlNhNGlUR0IyWVc3bDlPcktRQ0NxbndHNjRZOHUx?=
 =?iso-2022-jp?B?WnRkMmpYVERCcjFDM3V4V1BsTjZPMFRyaTNvNTQ0eFU3N2ZyM3ZLUDYy?=
 =?iso-2022-jp?B?QzU2VVFrckY3dkZyTGJYT2ZkcGFrWEowOGVDZnF6SGpzR2tYZ1J3Q0JD?=
 =?iso-2022-jp?B?MXlTdHFrc2w3WXJHMHd1Y0Z6djBGcVkvZ1dmNnhmTGNIS3RRb1FLVEtw?=
 =?iso-2022-jp?B?YnJ5TTZHVDR2Z2ZqMjg1ZldlODBqbEdUMGVtZkhJYUgwRzVZSDJFbktV?=
 =?iso-2022-jp?B?WFRRbmVRUEs1LzJ0a1g2VTNMTnhqZGVIOGEvZ0svOVROTGpjMW4wQmh1?=
 =?iso-2022-jp?B?RjdFL0duR0NsRjdQNEt2eTN1Nk9qaXF2bjVKcE5IZ2ROVmFzZUlqUGVk?=
 =?iso-2022-jp?B?RGY5MUF5MjhtcTBrWitSUVlPU1h6WDhGTGFZazQvUnhCOVZJN0VFYm9M?=
 =?iso-2022-jp?B?c2crankwVTRaQStLQ1BqSU1xdWp2RnNGcDZ3RGh0WlRBMnR3clRCaENi?=
 =?iso-2022-jp?B?TTN6ZW1JQ0ZoVkJxVWQ2aG5UQ1BheU1BdTYrWTByb2htd0lqRDNGRHpH?=
 =?iso-2022-jp?B?MGRia09GSHAvU2RDMm94OGRIUzd6MmVQWHRYUWloZ0t0QWtwelhmOG9r?=
 =?iso-2022-jp?B?ZFg3QVlYRVl4Ris2ZnhvOXpRbjRZN1B3VStXakMzVHJLUUJPdlRoQ25B?=
 =?iso-2022-jp?B?Z1hMRnYrMm5QUFpFTVlmQUVITFVtaWhmSmlYU3FOb2RxSWpzVWpMYUN1?=
 =?iso-2022-jp?B?M2pFVjg2TUZsbmdWaWx4blo4VStOSVFsaElpRUEvN3l5YzAwcFI5MDMv?=
 =?iso-2022-jp?B?dS9XR1NNUWhUVUtqM0hMa0ppQWRMMC9ucWxuOVdoaHk5RVZGUFJpRjhl?=
 =?iso-2022-jp?B?RHJ1M1Z5dnhHRzdvblVWOWk1empVUDBhY2tJQnA3N2lqNk85Si95R2Qw?=
 =?iso-2022-jp?B?MXBuVFp6MkZJNHNVRzZEWExaSSttVklGY1ZabktOUDR3eE11VzU5blFV?=
 =?iso-2022-jp?B?RHF3RWtScXFFR29ldnFwblRKT3pQcmdhTWsyVWFRbW1ZQy9xRWcwNncx?=
 =?iso-2022-jp?B?bzJFSThSY0JTVUpEeWN6NFhRSFVHU0IvT0ZZWmViQjNwVlkvZjFZNVlW?=
 =?iso-2022-jp?B?TWhjd3lRSnVBaDlDUGlzanhTSnZaYk5mdndMZFUrS0UvN0Y3NEthN1ps?=
 =?iso-2022-jp?B?TFdkVE9MMnRrNDFINThQd2RleUpiTE0yY05SMnVzZDRocjlnSWlTMk5I?=
 =?iso-2022-jp?B?UXdzeGxGSnBOdHh4cHZ1SUtxNUdKaW5RMVRjSVJ3aVJWQ2h2dDhRa2tE?=
 =?iso-2022-jp?B?OGNaelVkUWw2VFNCMWlHWGFhd09rUzgyODVpamdMa2haV2c2WlF6ZVgx?=
 =?iso-2022-jp?B?Y3VwNjNoYkRKMDBWcCt4Zlp3NmJxODVxS3JZdHBBUDU5UGRHU2VoZ0FQ?=
 =?iso-2022-jp?B?aVRKL3VKNUE2NWtjeUdGSEN1UW5hcTBseFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29259e6-8bf9-4f43-0baa-08ddac98c518
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:43:49.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/lZrG5oza1BLHcYGqb9SVqQhEfTyWxtwObJ6TjjwaAOmVvmZWRdM7spT3fxUNGawMQU5NXLnEQFTsECswou2eVWqito8OKvFUmT/FD0RBMxRMVQirZSRt4KeNEPduQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 05:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19090

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, June 15, 2025 3:16 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; prabhakar.mahadev-lad.rj@bp.renesas.co=
m
> Subject: Re: [PATCH for 5.10.y-cip 0/1] Fix build on rzg2l-video.c
>=20
> Hi!
>=20
> > This fixes a build error in rzg2l-video.c[0].
> >
> > ```
> > drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:532:8: error:
> unknown type name 'irqreturn_t'
> > ```
> >
> > The main cause of this error is that linux/interrupt.h is missing. And
> > linux-5.10.y-cip needs the following commit.
> >
> >   media: mc: Provide a helper for setting bus_info field
> >
> > Adding this commit will also fix linux/interrupt.h.
>=20
> Thanks for doing this.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>

Thank for your review. I apply this.

Best regards,
  Nobuhiro


