Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02BEC83F11
	for <webhook@archiver.kernel.org>; Sun, 27 Aug 2023 21:51:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.1225.1693173110401933551
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 14:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 37RLpP6V3371009; Mon, 28 Aug 2023 06:51:25 +0900
X-Iguazu-Qid: 2rWg4AOIkzznmdaZpD
X-Iguazu-QSIG: v=2; s=0; t=1693173085; q=2rWg4AOIkzznmdaZpD; m=vBwJY7y2qwtkabKu8QQ+MncIvMp0aPjGl3bhTsn4vpE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 37RLpMdI4046113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 06:51:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjhYd2UrXz1df7BWsKwAZXr4z9PBqK9YFUzk9Qe/UrJe+YJNotTF3NUnCX5kDtas9/rmdoWP4tiUPak1hfMpfgQYloUIBHMO0w3VqnqhFufe+gxGCIIFNKz1VgZTiJtyVrDnr4qErmvndLSOPQz36p7kiULcCMqWbiMV7koLMujaWnUhcN8NdN3FtC4mP3T6wXy0lf1tIBhNfRoJ+cj2sbQyutpNwIRyuk1JwXMlC60TEilcwdbz3AnYTfUCkhYuBinCN/oPNdVuTTckm62D5FFB2vHyQufp3RdU5Qmd6ga0ucVC+eDVhzcO+DDQ1hfNRbTis1MsM3krbMs5Oidw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi+grB4USYl2NYReoR/41BOC4yydh/DCMic6m1t98VU=;
 b=eTwE+l4VymO7A73vxOHa5+18CkzOOl/64ZrCqcOuFpTF8KYmRKfAQijg/DZ7cx7WYaIJbKcOtZF9DU6MkeoNsUEQlGqwy2HxbDC8zNI3FwvPcWTx6jenmZtU/360MF8Pk1iVdhhF26fh453F8b29X+6H7X9cc8beqW0WOR1YTDWUc6/CnrNy8sR9ez/pCyQOtWYZ21ImydA+Pfr93xeuwm2iYk82huelB78OC4y38iU4BIUiaN+QqR8miwSNLB6jWr2FjSy0KJO8rNzsNIORya/S276XOgpZYRx0/+XlR6TWUYf7FO/pKLtagcn3PrmhdSZiHoWgfd63NelxcOem3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.292-cip102, v5.10.191-cip38 and v6.1.46-cip4
Thread-Topic: [ANNOUNCE] Release v4.19.292-cip102, v5.10.191-cip38 and
 v6.1.46-cip4
Thread-Index: AdnZMHVhxx+DYiYXT6qPyg9sLw9E8w==
Date: Sun, 27 Aug 2023 21:51:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200B1C2A049E2B57349C4192E1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11594:EE_
x-ms-office365-filtering-correlation-id: c2f4a97b-b20c-4ec6-7454-08dba747be70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8lKJ26QxTcLy1r3/F7Esb6Q5oOzjBFs+hnJQ5CdtcnTSrbbUedzyMegTXAY5Ug9kBjvmq81eNEtHNvsZwkPhS3tFrb7SrRRMvwraytQ7Th7vRed9Bw1Yj2aCsN1BH9w6CiQN5eWUcQAg33z5Vn8RLhffQdEH4m1PRftb7B031y9teLstWfsdMXulazTO9l6Vn+huL5c8Hrl6q1lpDIAB5QCylZ1FVayZKk7hhPwc8E+T9wrZnUr5p3bXrL+QZKYHPG3CLWH2J67iOHwL00zNt2AzWSslqRYlAbZ19WRPYkhn8hr+ybci39659Ua8kTj6K5p6kmR1fySlNGQTE0Uynxas6FCEX76ox6hWcBZ0rDG7aZzgsCKzCjSl3w2SIiJoqQHrwIhSHJcFKjvQ5oEWcpZ4q1MVbGEfKv9oXf45hYJnosuZs3hVGmDpLSfb6Exb9ZH4P80u1mKuuaVcM+iBPBjnf4wNbYVuXNkkSkBZTzCIQATljWrvM2JbJ2aoQlW54LLjdhL3HJqaBrrMDbp7oEOIppTCjkH2n861cbQFB69zv3kcYUF9ixZN9wPtMREzAryEnr8QgD9OTf+QSBi1R6uQ7bGAZWw10yjn455KSX66JFByEL5ujO1JAOYKD7xF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(1800799009)(451199024)(186009)(478600001)(9686003)(6506007)(7696005)(966005)(6916009)(316002)(71200400001)(83380400001)(66556008)(76116006)(41300700001)(64756008)(54906003)(66476007)(66946007)(66446008)(122000001)(4326008)(8676002)(8936002)(38070700005)(52536014)(38100700002)(2906002)(5660300002)(86362001)(55016003)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L0dNelU1allzVFlleFVsTE5Eb0NueWlUYm1qa2twczRvRFM3UHBFSWFs?=
 =?iso-2022-jp?B?cDlTMzJMbXNibmVyTGVWZUtmQytLSzVoaWpMaGZnNFBDMDZjaDdaT3do?=
 =?iso-2022-jp?B?dDZCWnpJZWZ5SWMwUkdqMDU0M0RsZU4xMklUdi9telpseXcxR0VWanZx?=
 =?iso-2022-jp?B?b1hMUVk0QjFVb0ErVTluS0M0bEdtSTdMcHQ5Tml1VS9FQ2ltem50ZzMw?=
 =?iso-2022-jp?B?YnBCMDFtd0tNYXZpeEYvUURnNWhXL1VJa0VEVFczNVlpWEREN09VZ3V2?=
 =?iso-2022-jp?B?WE0zaWZQZFNaMDRYeTF6VVB4QWZSOGREaGNxTGM5YU10QTAvUnA2Y1NM?=
 =?iso-2022-jp?B?V09ISEhoejdlRWsyMXdyRXJHZFZ6S3UvSk1XNzNiZ1BIY3ZNejYyNG1i?=
 =?iso-2022-jp?B?M3UxUjZhdGRtSHpKdUs3S1poRXkveFk3ZFpRVWZKOTdFRlhNOVZoL0tC?=
 =?iso-2022-jp?B?SWYwVUc5T0VoZHZWWXI5YVZvWDFPTGxMVmI0eFE1eXQ1aWxobE52OW41?=
 =?iso-2022-jp?B?b21SbEdZSUpxUXdLc29sRkZuZU9lUDh4dUFOdERCODl0OEJycU15alRl?=
 =?iso-2022-jp?B?UXF0cEVwOUc5Vm85R3ptL01sQlN5VHlmUXBnNkExODhucGZOS1h5a281?=
 =?iso-2022-jp?B?K1diRkEwTi9oM0k1UW54eEVNVmpldGI5Mmx2N2FJMzZrNVdCdU1OdnBz?=
 =?iso-2022-jp?B?YVZMdUpIOUhTOVYyNU1WckFGZ2lmeE1sRWNIQ1U3VDlGaVBnUmlxSnpn?=
 =?iso-2022-jp?B?NzM0T3ZzcXYwd3B3Yk1adFJ4aGtzZUpDQXY4K1h0OGd6ZjZ4UUVBUElW?=
 =?iso-2022-jp?B?Rnh3cGlqOEhoRzhVeld4WklrbjEzZzh5eHBST1N2NHFCbEZpTDYvS1ZE?=
 =?iso-2022-jp?B?MFpSaUNSVEltMjNTcmhoc3dJVUtHVGxYTzZ4cmVqdUFLUytXK1RtV25P?=
 =?iso-2022-jp?B?a1EvM3JtLzRTR3UzRWpPVGJDL1Q5TnBpcSs3c0lEUTFJOTQrRDVKLzFV?=
 =?iso-2022-jp?B?NnU0QWZkN2JIdlJoM1FEZ0E5RmlJMGJOb0NUWUxPbDRLTjF3Z0pWbktR?=
 =?iso-2022-jp?B?VXd0ekQvSFcra01iM0tqZ3lyMTZwYUpySStzNzB5M0w0ZlUzS2R1TnIr?=
 =?iso-2022-jp?B?Zm0rd3UzSmxNZ0ZLZnNZWEpoeXhYNVFrZUZVaVp6d0RxcVMwbzczRGd6?=
 =?iso-2022-jp?B?SjFLcUVNbGRWSWxoNUwxUEpaRmlxb0dybXlNTHB3TCs0ZGkzS3V1VFhE?=
 =?iso-2022-jp?B?aFg1dVlsVk0wV2tTOTkzNlFOYkdDTVpWQWtqSVJCZXJidkxPZGpSNWJN?=
 =?iso-2022-jp?B?SmhzNThxMXAyYXlheUtYZG92eE9ZNEViOTBZWkxpV21WUlRFRi9WQTNP?=
 =?iso-2022-jp?B?MkxEU1RPSzJ0UWFNTDJFUG01Ujk0Q0RkMzJoc3daY0JLamcvZnhINnBp?=
 =?iso-2022-jp?B?Q296QjFVazVZSGY0d1ZzV2ZjM1FkVVl1QjFhS2NrOElIVmw5d1BFL1FG?=
 =?iso-2022-jp?B?dm5vL24wQUhJL09PQ096dSt4TldWVUZmdkE0ZVJqUElYbG5BcWNHakJy?=
 =?iso-2022-jp?B?QzNacEErZjRVMkJCVVRxT2w3NEZLWHFEYTYvNGFoclN0eFUyZ2pmSDBk?=
 =?iso-2022-jp?B?SzhKVVVIRTNwdURiT1R4WEM5NExyQkMydUhBbmYreVg2TURnR1J0d0tW?=
 =?iso-2022-jp?B?M2NqaHpDR2ltWG5vMlNyTWZ5WGtnbGIrSlZOSzN0R0JtYVdkSGVZZFR1?=
 =?iso-2022-jp?B?NExVZCtFYXUzSmJQTHkvNTJBZGprSVZ5TXROV0hOQmdBSmwzd0tabUhw?=
 =?iso-2022-jp?B?V3VLeGlGZDBwajJqRmhidVZpMzlqSmFXWkRvcHNET2FEZkErSGcvemtH?=
 =?iso-2022-jp?B?QktVNFNGcGJucTRobUUwbFZHeXBuNXdRRmNoTUIyK3hjdE1zdkJERUNC?=
 =?iso-2022-jp?B?enQ4aFQwdWNkOGd4cGFtNHNFMEZUazBCZmpseW1KOFEzYW5GSlhZOCth?=
 =?iso-2022-jp?B?UHYrbEFzSC9qQ1Q3UlBVSWpaVkEzSXBLbHlYN3N4alFWVkFCbzUrUmRm?=
 =?iso-2022-jp?B?Yk9ZYWNpUDE0RVVOamZYTGpMREVoVVBnUFVLOVJuSmhUbGY2SlIxMXRU?=
 =?iso-2022-jp?B?RVFBeWE4UVluMUpZUjFqb2lNY0ZGY29LdjhyY0ZpNDA5cmd5K3BEdTBs?=
 =?iso-2022-jp?B?U0ZzUXAxREhIUlViMGptYTFLRnM3ZURDemxGdjZpQXVlME9RcDZJempx?=
 =?iso-2022-jp?B?cUtsM3orRDNwY0xxbWYxWi9QZDJGcUpwS1pwL0dOdE1MYnVLSjBsN2Ru?=
 =?iso-2022-jp?B?aFBEV0NpVjNJdjR5VVVDWktFT0l0K3J2Y2dlcm5hcHB6aExnRytMcUg1?=
 =?iso-2022-jp?B?dnc1VTdSci92cFEybmRKNDNOZHZudml4NnQxTXU1R3Q1VjJPUzR4WnE5?=
 =?iso-2022-jp?B?MzBmZ2xnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?eEQ2TkJkTERDNmhLL3dSLzVpNFhWY1o5K3grUUZYa0dlcXVyVy9iVnJQ?=
 =?iso-2022-jp?B?Mzg5RDJQb0daK0owRFNMT0p4bVdBV0JId0lYK25GT29yLzFsTUhCVWQ0?=
 =?iso-2022-jp?B?Yll3b2RSWEFudEVIZnRqZzR1MXRiZFMyMkNWb2toWWZzcFAwUGQ1VFJB?=
 =?iso-2022-jp?B?NUdjMFE5MFI3TlRUQUF5OHRBK2ZaVHJZb2hHa3ozY0k4WkZZWXBObFZ2?=
 =?iso-2022-jp?B?Tm1xNmtUa2FRaVc0ZCtpS1llc0VFOU1OZ2ZYeDFhK1dxZHlwUWN1a2ZK?=
 =?iso-2022-jp?B?TTlmZ0U4dnM0YkpSYmJoWldvOXJpcW1vR2FxN00zMzVuSldGVWtXOSs5?=
 =?iso-2022-jp?B?eEpnYlVndmZEck1rUWRnK1hGMldTMnJBUXM4VnF1R1FMTXd0OWp3Qkt2?=
 =?iso-2022-jp?B?OXhqaDBqakFqYWlWdzZ6R1hlaW1DQWFSWGJEanBDSnhkSUZ2cjBpVWEv?=
 =?iso-2022-jp?B?OFJuYkRqM204Q2FtVzJ1RGtlS05HNVNMYzFWUW9FaXhFWlJJUVFncjVJ?=
 =?iso-2022-jp?B?WEJvMW1ScDdCcllxL1BYSkU0MnhjUHpMaFROZjMrTzM3Q05kazJwWEhz?=
 =?iso-2022-jp?B?RWVLMWxxZnZKdEZKZU1KWkNyZ1VDb0RmY3BPZlBqV3dxT3JjSC8zNURQ?=
 =?iso-2022-jp?B?RWhOdUlvMzc2cDZpWDBaTWJENHVuejdLUDN2R2tEL2Y5ZCtYdXB4aHlV?=
 =?iso-2022-jp?B?Z2RLM0pRdmk1U2haMEJuM2hES01ZMjdxNkZiQ0RFeTBlS2JuUTRDbEFj?=
 =?iso-2022-jp?B?eFNoMzdBL3k0RXdrM0pjMWVrTlFrVzFwM2pkVkpjdXZKMmRZUGcxVTZh?=
 =?iso-2022-jp?B?NThraDNWcW9iZnRGNWNucnU3ZWdSV1lXV00xcnV0NklZcE5zR2ZuWERJ?=
 =?iso-2022-jp?B?OUdkNXdKcURmWndvUWVYZVZ2d2R5RXhMbkx6bWJRZ0k2OXVNYjZzdEsx?=
 =?iso-2022-jp?B?b205WXhuU3VNL29YOWMyRWRFZWQ0Zld2TFo3blFVK1Zoa0dmdWRsK0VF?=
 =?iso-2022-jp?B?UjZnUHVyUnNJQXo5MDhGY2RRK1Q5cEVqcGxsallyYmNJanJxRXdOM3VO?=
 =?iso-2022-jp?B?MG4yaWxTUEZ4RFZCZzNIUmorcFI3a2RyVXc2amVCTEVDRTd0WCtMeDUx?=
 =?iso-2022-jp?B?OGJLcXVsRTBtc3VjRXB2aStuOEhXQ00zVHNkajRzcXhGVTdsQXJKc0NZ?=
 =?iso-2022-jp?B?aFltN0FxVmphSVpOTzBYbCtSY2E2THBlNzBjdmpaY1FJVkVIVTJPMUJ3?=
 =?iso-2022-jp?B?c3dDcGdvWTJIM2hnbGpnQzJOMkdHdUczeXQ4QjE2K0lPNlJOTWFPQ1Qw?=
 =?iso-2022-jp?B?bkgvY0VhVE8yeFR0NDF3b1V4djNTZjJLRjRFRFN3QTgyaWhZMzBDVHNN?=
 =?iso-2022-jp?B?UTNEM1Z5UGlWNzFLUFEzQT09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f4a97b-b20c-4ec6-7454-08dba747be70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2023 21:51:18.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yd9mgdIvIzm4ic675AftuihsqwTKlKkz546DcwspoQt3DJOzr8FHYTDX7NWiEsBWMNBP4szqWLrHhU+5qzeaAg8idODvEPr+0M/OY1zk1+YuI5Uc45U1oRxlYQXWf5uO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11594
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Aug 2023 21:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12856

Hi all,

CIP kernel team has released Linux kernel v4.19.292-cip102, v5.10.191-cip38=
 and v6.1.46-cip4.
The linux-4.19.y-cip tree has been updated base version from v4.19.288 to v=
4.19.292,
the linux-5.10.y-cip tree has been updated base version from v5.10.186 to v=
5.10.191.
and the linux-6.1.y-cip tree has been updated base version from v6.1.45 to =
v6.1.46.
The 5.10.y-cip tree and 6.1.y-cip tree added fixes and some dvice drivers f=
or Renesas
ARM64 SoCs.

You can get this release via the git tree at:

  v4.19.292-cip102:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      372689399d20f850142c3d734cb4365cd8a31242
    Fixed CVEs:
      CVE-2023-20593: Fix Zenbleed
      CVE-2023-34319: xen/netback: Fix buffer overrun triggered by unusual =
packet
      CVE-2022-40982: Downfall attacks
      CVE-2023-3212: gfs2: Don't deref jdesc in evict
      CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads =
to use-after-free
      CVE-2023-4132: smsusb: use-after-free caused by do_submit_urb()
      CVE-2023-3609: [net/sched: cls_u32: Fix reference counter leak leadin=
g to overflow]
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/s=
ched classifiers: cls_fw, cls_u32 and cls_route
      CVE-2023-40283: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_re=
ady_cb
      CVE-2023-1206: hash collisions in the IPv6 connection lookup table
      CVE-2022-20166: drivers core: Use sysfs_emit and sysfs_emit_at for sh=
ow(device *...) functions
      CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write
      CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_e=
nqueue
      CVE-2023-3117: A use-after-free flaw was found in the Netfilter subsy=
stem of the Linux
    added commits:
      CIP: Bump version suffix to -cip102 after merge from stable

  v5.10.191-cip38:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      78bddf33c2b7d94fc34e09bc56638615095ddc28
    Fixed CVEs:
      CVE-2023-20593: Fix Zenbleed
      CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads =
to use-after-free
      CVE-2023-3610: [netfilter: nf_tables: fix chain binding transaction l=
ogic]
      CVE-2023-4132: smsusb: use-after-free caused by do_submit_urb()
      CVE-2023-3863: net: nfc: Fix use-after-free caused by nfc_llcp_find_l=
ocal
      CVE-2023-3777: [netfilter: nf_tables: skip bound chain on rule flush]
      CVE-2023-3390: netfilter: nf_tables: incorrect error path handling wi=
th NFT_MSG_NEWRULE
      CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid
      CVE-2023-3117: A use-after-free flaw was found in the Netfilter subsy=
stem of the Linux
      CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write
      CVE-2023-4004: [nf] netfilter: nft_set_pipapo: fix improper element r=
emoval
      CVE-2023-21400: io_uring: ensure IOPOLL locks around deferred work
      CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_e=
nqueue
      CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference f2fs_write=
_end_io()
      CVE-2023-34319: xen/netback: Fix buffer overrun triggered by unusual =
packet
      CVE-2022-40982: Downfall attacks
      CVE-2023-20569: Speculative Return Stack Overflow (SRSO)
      CVE-2023-4194: tap: tap_open(): correctly initialize socket uid next =
fix of i_uid to current_fsuid
      CVE-2023-4273: exfat: check if filename entries exceeds max filename =
length
      CVE-2023-4015: netfilter: nf_tables: skip immediate deactivate in _PR=
EPARE_ERROR
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/s=
ched classifiers: cls_fw, cls_u32 and cls_route
      CVE-2023-40283: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_re=
ady_cb
      CVE-2023-1206: hash collisions in the IPv6 connection lookup table
      CVE-2023-4147: netfilter: nf_tables: disallow rule addition to bound =
chain via NFTA_RULE_CHAIN_ID
      CVE-2023-3995: [netfilter: nf_tables: disallow rule addition to bound=
 chain via NFTA_RULE_CHAIN_ID]
      CVE-2023-20588: x86/CPU/AMD: Do not leak quotient data after a divisi=
on by 0
    added commits:
      CIP: Bump version suffix to -cip38 after merge from stable
      rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
      rtc: isl1208: Add isl1208_set_xtoscb()
      rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
      rtc: isl1208: Make similar I2C and DT-based matching table
      rtc: isl1208: Drop name variable
      dt-bindings: rtc: isil,isl1208: Document clock and clock-names proper=
ties
      dt-bindings: rtc: isl1208: Convert to json-schema
      rtc: isl1208: quiet maybe-unused variable warning
      regulator: raa215300: Add build dependency with COMMON_CLK
      regulator: Add Renesas PMIC RAA215300 driver
      regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
      arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node
      arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
      arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names for MT=
U3 channels
      tty: serial: sh-sci: Fix sleeping in atomic context
      pinctrl: renesas: rzg2l: Handle non-unique subnode names
      pinctrl: renesas: rzv2m: Handle non-unique subnode names
      arm64: dts: renesas: r9a07g054: Add MTU3a node
      arm64: dts: renesas: r9a07g044: Add MTU3a node
      pwm: Add Renesas RZ/G2L MTU3a PWM driver
      pwm: Add a device-managed function to add PWM chips
      arm64: defconfig: Enable Renesas MTU3a counter config
      mfd: Add Renesas RZ/G2L MTU3a core driver
      dt-bindings: timer: Document RZ/G2L MTU3a bindings
      clk: renesas: r9a07g044: Add MTU3a clock and reset entry
      arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
      arm64: dts: renesas: rzg2l-smarc: Use proper bool operator

  v6.1.46-cip4:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      58f7d1bf36cb697e7cab922b71d04f7d925e3b1f
    Fixed CVEs:
      CVE-2023-4155: KVM: SEV: only access GHCB fields once
    added commits:
      CIP: Bump version suffix to -cip4 after merge from stable
      arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
      arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
      mmc: renesas_sdhi: Add RZ/V2M compatible string
      arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for GI=
Cv3 systems
      arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
      arm64: dts: renesas: rzg2l: Add missing cache-level properties
      arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for =
ETH{0/1}
      arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO i=
nterrupts
      arm64: dts: renesas: r9a07g043u: Add IRQC node
      pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
      pinctrl: renesas: Add missing header(s)
      arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
      arm64: dts: renesas: rzg2l: Drop #address-cells from pinctrl nodes
      arm64: dts: renesas: rzg2l: Drop WDT2 nodes
      clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
      clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
      arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board =
DTSI
      ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
      rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
      rtc: isl1208: Add isl1208_set_xtoscb()
      rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
      rtc: isl1208: Make similar I2C and DT-based matching table
      rtc: isl1208: Drop name variable
      dt-bindings: rtc: isil,isl1208: Document clock and clock-names proper=
ties
      dt-bindings: rtc: isl1208: Convert to json-schema
      regulator: raa215300: Add build dependency with COMMON_CLK
      regulator: Add Renesas PMIC RAA215300 driver
      regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
      arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node
      arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
      arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names for MT=
U3 channels

Best regards,
   Nobuhiro



