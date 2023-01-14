Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF0C54EBE
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 00:37:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.106052.1673656652612678862
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jan 2023 16:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 30E0b8aK009560; Sat, 14 Jan 2023 09:37:08 +0900
X-Iguazu-Qid: 2wGrYclpvdIPYTcCTg
X-Iguazu-QSIG: v=2; s=0; t=1673656628; q=2wGrYclpvdIPYTcCTg; m=OjNhxqhc5HpEfZOYmHUj5vQk30dvnS8meqVLBRtxkr8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 30E0b3RB027104
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 14 Jan 2023 09:37:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj7PyuO47IARyDUiDnOlwq8abYpjbwRy5sbUNHRw8Gdgz8tzkwxcwNs5fHDLhk+eg+L06MYKotI9NZ0NIGIhn9FB5tH9CzC93WArvUMx1T7sTwVDR9SA8wxcdMMIb4tZZTPuoX9uazS0EitZ9NCgWrINsdKx2rTnYSkc2M/hdV1mENVGfe3snm14P6kuKJObov0pAmUxEVlaFdA/xePzcqYRYXGcFt0KYTIyuor9I+Okzuo57lGt/6AIiHRbWS3pbLwnX/XmJt4bwzo4bHb/3A8vCZtuV6t4aoqQw0cbIy4aoh/RV2JSqpLMwecquh1nuo4U06jn/ceo74svi4SQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFrxpB8uZCyPnNfHZmmNXPHiL06RwNFuUyCV7jTS7MI=;
 b=oZLbGu+/7NffaNMFKVJN3e+/kSsaqjlUsSNL/xFBPVs3TwAWRo614IAX415dQZEVYmiL6cxtZ6ERzwZQfo26b2gyw9dzMbywX+37alJ3RHmuHajy7g7uDKSpGCOLHobueFhLw52f0sT8M9J7M6zvEcgmf/7QGyEBI+D1njwTsbTuT5iL4SfAgJ19ck3fmyVjJLTAXH1xHw13SrVrEY0ozXmMcHNxttPrSshqfiBwznbdyQhxzoQK1oJYcSHjv6RyNCNlnT10WMn33L52D3IAOeNTxovzNVPv7ocETFc7jVSOo6s3PEKh8GlNv/3d1umzgX6+PksKWIs/FDikIFHm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v5.10.162-cip24
Thread-Topic: [ANNOUNCE] Release v5.10.162-cip24
Thread-Index: AdknsDKrFkDaTcyZSx+WeHkuV73PKQ==
Date: Sat, 14 Jan 2023 00:37:01 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420CC3751D83FEC1ABD676292C39@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB5781:EE_
x-ms-office365-filtering-correlation-id: 88412274-d44a-43e9-065c-08daf5c7737f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kq1vS5wTEAJcilun35FglHankPqDTKSLo1alquxL75PJ5xdGNFu1VtlCAhSbgVrgAwWshQA2sL4w13pxFf+yE8/dRvTy+539sGETxFmigK86MgllJEjLAvyJwSuna0iGXX/SM7F14jwTu0rEOT+ffMvm13G+dkeu6JkRlh/uThoZCY7RyX8nGMRL522kGRY29khPq5iePpw3Y8KMQ9Boso4TLeHFPuIG1mEQDfopftwgvxcsLkxkNbxe2WxXD9e/BzrEk9GP1FPhQk5XHyKxvdGnLwF3T/fB//lIfriZBnV8JDSHM4Zs55pfqnGr88LzdgBB0yg8PUuxybZijswxzcHl90iPzraJp1PayjFTtNMPno+VtIFSUuWRRuw8cRsRFa466E7ZfqOAB66bJuomfQbyY44Yl+GtZhi0/gt4MpuwXmAH5wkrzhrIlauwFAiJ7b7XTTdG9aQrDDfcyFvqqOYVWMMC+1tCewez1kjt0+GYIjExlxhFPQAeuIQnO6O6/3kSUQArr6YyWlHHv7Vcd46LwLFeyysFcpTvKyZDHJCb52ieI1wBB6uw36lbLeTDqghHrbAyFlfMIIhSnBTjZvigZubYW1PP4hLhM9Ihhfm4opbHx9o/Vsxa4iwYJYg3V4prg7TmRhf8AmGcHgWF/0irA2F4OmmzhBY7WW3HTtyMNHKvuiKhT89VTo16NtkH/SSBmfAo0GLOGeEKyWjse7MAgDgi/PHIm53HjyrZqIw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(26005)(966005)(8936002)(52536014)(186003)(5660300002)(54906003)(38100700002)(122000001)(8676002)(6916009)(316002)(4326008)(71200400001)(38070700005)(66446008)(64756008)(9686003)(66556008)(41300700001)(66476007)(33656002)(478600001)(7696005)(66946007)(55016003)(76116006)(2906002)(86362001)(83380400001)(4744005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cTg0ZFRxTVR0VmZXdWcxcnRYR2ZOQ3hVUC9KYk5ka1I5NmFieHYybytR?=
 =?iso-2022-jp?B?QVRDZi94OWpnZFpVRC9MdTVmWHpNS3lpU0xvbEJnR0pxMlpkcXNKWERr?=
 =?iso-2022-jp?B?VkI5QzlTclNKWHh0c01LL3U4bkErcjNNYk9SeFNSTnpGUm1oRDZYNHBJ?=
 =?iso-2022-jp?B?NVYrZ0kxWlRucGtQc09iZGlUSFJtS2NhZjFGZUdRVzYzSjU1TTdYa0hZ?=
 =?iso-2022-jp?B?S0ZTWU9BT0RucHlXV08rMUU3ZDF2WkxnRW44YkJRNFhVa21XMkV5bFFV?=
 =?iso-2022-jp?B?V0xiSVFPc1VZa3k3bkxFbmlKRGk3UFp3WkN6Zmpxa0ROTTdqN1Y0OXB6?=
 =?iso-2022-jp?B?dERHTnpXMWpWS2x4K1BEQUdualZzYnQzL3ZFTVh4bkRieTZ1anYvMm5K?=
 =?iso-2022-jp?B?ZE00Z1E2QjhIVGlVYldaaUt5blFicXp6TXd1cW9pNXV1ZEQzazVHQmQv?=
 =?iso-2022-jp?B?ekdpSXNndGhrdm83YmlRMWpIZUdIdmdBWVhnYmNWMDdZYktrK0dGOUVn?=
 =?iso-2022-jp?B?dXAvNU1Eb0NXM2U4a1hpZTlFVG9IOEtWcGtoait6RUFoeWtGTlpLenJQ?=
 =?iso-2022-jp?B?T2tZNWttU2hpRjV5MTVoUUxJSW5DSmR4T08xNXpPaUxRa0g0VlV3MDhG?=
 =?iso-2022-jp?B?YzBTVHNjcTdhcXZvTlRMRUh4OFRNMDlxWjNYTmNEL1R4Zk1pQ0luWVFk?=
 =?iso-2022-jp?B?cUdqb29VczZFQTZQMWY1RTV2cGp3ZWNFRGxIUzlsR3puSzhiQXNGR2VZ?=
 =?iso-2022-jp?B?Nk9JdFRabmVicWM1MEhhc0RrS1lsNUx0YTNUSGE0VmlNa21Sd1piTzIw?=
 =?iso-2022-jp?B?S3N0V0tpTGhQMUMxSDlrQjFzOTQwUzhOdnJjaWFKbVp3VW1rMkdhU2o3?=
 =?iso-2022-jp?B?MUhzdDFXdEV4VXI2b1FYOVB0eGpkaEVlcHVFZjV5czIyaDRTeERwY2U0?=
 =?iso-2022-jp?B?OUNMVmxtb1hCVlRxTW1wZmZ5ZjV0amdhR2FQeFRxbnFWR1NaajRkTW5Q?=
 =?iso-2022-jp?B?VUtnd1prbE50dGhlQ2E4aW5IS0M1WUFPZU0vZThTek1sRVlVT0Y3Znl2?=
 =?iso-2022-jp?B?Y2xsQklWejRaK1hkdXBhRHMxRHFsK3Ftc0Q4b3BmNWdzK21ubGl2cGc0?=
 =?iso-2022-jp?B?cEtBc0ZtOC9jYlJpWUpGVTdUcjdta1ZueUNCREJJZHI5ZG90K2dWc3Ft?=
 =?iso-2022-jp?B?REZGR2lZQ2U3TnBIcXQwVUI0WGNkbWZWTGdIVXd2Yys3TmRYVURwVVlP?=
 =?iso-2022-jp?B?Y1BYalUrWStSbE5NTzEyUnJoZXNPamdVK3FBdWhpb2pRQmd4dndJWEh4?=
 =?iso-2022-jp?B?SWNKOHpVM2dHWU1jVFd0U0lYenJyaDJWZFdtN3ZXTHV5QTEyN3QxUlNZ?=
 =?iso-2022-jp?B?Zm9DSk9zeXVtVUlSQTFrd0lzQ0thaDR4RnJFcEpXUXlKTHphVDgwVUFV?=
 =?iso-2022-jp?B?R0tRNWduWUdIdE81OEpWMi9ZUUhyNzdwOEZlL0RvZkNuUGRpbTdacUFE?=
 =?iso-2022-jp?B?UGxUVTkzd08vVHFOeHZCeXVXc3l1K2U4UDl4eForY0tqYnQ0WllkSDYz?=
 =?iso-2022-jp?B?NCs4eGVmT1JLZ3BQNWh1REltMFhvS1NXWHR5M3B6b1dTNGE4NndYOHdl?=
 =?iso-2022-jp?B?bCtzdUo2dTlYYkxVQlVlMExBSjlhNER6ekgvUHQxbm84cEgySUdXazZk?=
 =?iso-2022-jp?B?OFE5MlZVdWlkdW84WVpTTlVEVTgvWmR2bVhWYko0ZzB6blh6WU1PRkxB?=
 =?iso-2022-jp?B?UG9YL3JLNVFkcHp2SFRWTGFlL0R0RUVvalkweklDVW8xWnNtNlZpaW85?=
 =?iso-2022-jp?B?eEVLY01wY010RUZPWms5Z0tyVWl5VHVXU0dPd05WRm9ZejJvWnF2Zmk3?=
 =?iso-2022-jp?B?RW9RRWZ1d3V3OUJMdVJZS0dGYWJjS0ZicitKaVZNYVEwbTNZOERPcWtn?=
 =?iso-2022-jp?B?WFN6UG95NTJ1K0VqUnpjL0JCMTBSV1psMXdkQTRGSndwK0g1dHh6d2xu?=
 =?iso-2022-jp?B?L3BvN1lIanQ3MjNnM1NhVTMwRnBYNVdFYVpnRnBnYjgrYkF2Z1BSUXl2?=
 =?iso-2022-jp?B?Y1lFSzdxbG9RZW00bytzcUdaYlhUcjFQcnNhaGRYWUJLeTlwVnhQeTVi?=
 =?iso-2022-jp?B?am1xM3l2QlZESm8wWXNxZXF4UUZLZGh6emNxR0NyNzc4MDF1ZWxzUWJ2?=
 =?iso-2022-jp?B?WXg1VHd4SEp6aFV1MkVSeGxQeHd3UnpjRXhycmVEd3F3U1J0UVFyUzBR?=
 =?iso-2022-jp?B?QXhiTG51V05sSzliZEZsOEZvYVZsdy9ybkZjK0pnc3FqNUZFRmJDQ1Z4?=
 =?iso-2022-jp?B?T1pBWThBNVczUG9RdUNXdk5oL1ZHNllsL3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88412274-d44a-43e9-065c-08daf5c7737f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 00:37:01.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGGpXRp2hXjcfu/H/uVqib/S79yKJVHGFoaY+xzvDDgUk0GEqK1M7jAVcElmR9ayYbTvcFQ+jdsPFfGbOxnFPl7FTc2GlDnn3etGyjiqaM+Fb4ogc8wUGS6Uk6NRRD2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5781
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 00:37:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10349

Hi all,

CIP kernel team has released Linux kernel v5.10.162-cip24.
The linux-5.10.y-cip tree has been updated base version from v5.10.161 to v=
5.10.162.
Also, 4.19.y-cip has no LTS release and CIP update, so there is no update t=
his time.

You can get this release via the git tree at:

  v5.10.162-cip24:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      7ef5f1fda52a95426084959dac09acdb3c81327b
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip24 after merge from stable

Best regards,
   Nobuhiro

--
Nobuhiro Iwamatsu


