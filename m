Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B26C001DE
	for <webhook@archiver.kernel.org>; Sun, 30 Jul 2023 21:05:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.81100.1690751133228231498
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jul 2023 14:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36UL5AGN529235; Mon, 31 Jul 2023 06:05:10 +0900
X-Iguazu-Qid: 2rWhW3wiOsGBOeersO
X-Iguazu-QSIG: v=2; s=0; t=1690751109; q=2rWhW3wiOsGBOeersO; m=/shCfy8vHRXR9yZxUwOqmML3lF6CcLWnUr4YUuyPX6U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 36UL56eW1969350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 31 Jul 2023 06:05:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMDn46JiaEhS52t4PNPYq7HvBfpDDDFmyt3XLk7KBgwxPkm0MHmqonTnqOQhZXheZjIpSEN50cqugtMQu+eSwAEbLby/RpU4d1SedMh1lbmGm7mUn/QodzhwsglCP9eugSe935zSz4aKHzruEJ7PPmdIGY1DxnxIasHmOhBSXfuhw0tQJwQSM9FbS31+ZbUhnDchpWtL4URYzfIytH0W0nNt61F9Byilb7bh8YHzRrMp40VPI0Pp2gd/+LuVrZP40bvlIUMBXMx0+IPvwzI50vYbqwjHaEqod4CT2xX4Rv1Bs6pSNWcC6zJhyHEJz+36Sp8tCZ9BbhsD1h/nayqvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPmtAYx3d8WiXNRgEADQ1B9jPG6t0hlC85Ag3MntA/g=;
 b=bsYdQv2cl6kSEEsKvtfulyV9Idi1ZpE8UGq7TfoPzP39zaYr5sVPmn/kYsiD4ejAwCRPghpJFPsLRDu6GKui23jv7WjB4pT9trV27IpSrlDVEXVs1kmUtcu5Pu7K8Qc7G28IYJzu2nO8jaKHcUpyzb3aERnVGbgrPazSIM8Vh5df/I5t4aa/IIseOCexyrN1uxYzRIr/A+53vccP7VUCZiWKHQPEY6zcmrR6+kZxts2wi/7B8hllg9IjCMRu9oT55wzEJWHXFlyF0tWZ2LIxNKFTS+Mq+BexCfRsmBa//WOlI0PJDrPTR8pIDX6WmW8j6b80wZPBDz3/f4uT469RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.42-cip2
Thread-Topic: [ANNOUNCE] Release v6.1.42-cip2
Thread-Index: AdnDKUK336VZ+MWrT2+divPqRzyFHQ==
Date: Sun, 30 Jul 2023 21:05:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942011D06E72CC490ADB67D19204A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9769:EE_
x-ms-office365-filtering-correlation-id: 1c6f63a3-8705-412f-3408-08db9140a4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tP1eYjTGJt87eTacI/lpYHJiii98xI8D2X4nl6kX+UahROn5VwDr8u9fvBCDRTI5DHkbiJ7je1ko0IEdDjWoX4CMyBnLMctJVw/dXq3SUKzS9ul50FzVXl0JrZSU38BKoJ+aYSAB5+dDJuRRZ9N0xseAKaH3+/kiZmQbdeM0einwKjLdhmk4UMRYk/dihF8IGf7JBEyMGh9eL5rlbMCEXO1vL7G4jqOYdymRScCuWqvx8MyDaZJh2NkT4fobzDuq4DEoMhYCggv1cBhBWwFMuZw+V9aJNsFe4zXYgDuRLLZy7L5AoMDf4Vqt2B/IpnN9x3lE5Z1sH3o8/xxsdfKtmxHfBSofNEIN+pKnbTxk1014ylbCzLCZein8ZjkotqkfuGoo/ggA0SNM5zbriX2ZtPj7vHSETSp3p3qBV749x1voordTz5xb65ZZy6qsmO0fYRezqEeVtxjkomqDuPdX3D9EMfxjw2Pm23b//o//4oderkuXzp5cIRSyLquteszUhgqECessBpUaF7dzqr2wjK9xff9O3aUPq+A6tA6ZQYQNLFx+DwZVrOe9mw4Z5qbOvhTp5gUP5Ds/cpoe/tNiWcHK0UMpJ4V4epyGhyhR7/3a//hS7PDS+l44bH8teyTs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(966005)(71200400001)(478600001)(7696005)(186003)(26005)(6506007)(8936002)(8676002)(52536014)(5660300002)(76116006)(66946007)(66556008)(66476007)(54906003)(2906002)(64756008)(41300700001)(66446008)(6916009)(4326008)(316002)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M081UkQ0TmkwcmN0cE9Zd0Q1QkgxTWhCRnFDbzdwRDRRRmFjR2ZJNWxI?=
 =?iso-2022-jp?B?Q01CTU9RRHBpRk11cEdIbmlHQ2VabVA5WDdXOTVTc2FnR2JYa2xORjB1?=
 =?iso-2022-jp?B?WGxqNnRyOEV5djNRcTZjcnNlWkxIRHlZcERvSFMzSXg3N0E5ZUtFS3Zu?=
 =?iso-2022-jp?B?UmlDOEp6U1ZyRW93TEQvZnNHM0dGeTBUOXAzTCs3TUt2SmVtbnU0eUln?=
 =?iso-2022-jp?B?am05aDlPaHQzaGJ2dGRlTXFuNVp5TlRGNnY2dmhmaFk2ck1jNUorWXo3?=
 =?iso-2022-jp?B?anNLZGovS3gzV28xamlrWGtnbjd0Q2VVaVdWU1hiTkVEK2IvbW1qYlFa?=
 =?iso-2022-jp?B?RVFTdStaN2NHK1ltZk8xQUlrRmtzb3FiNWJlWFlrZ0hRMzF3QU1UNUZu?=
 =?iso-2022-jp?B?cTNGU0NSWUwxcnBPbEYrSy9jM0tqV1BjczVXbXowejBuNGczcVM1c0tF?=
 =?iso-2022-jp?B?RXU1N2labXRjVk5INVovSnc0Y1ZkTUFRdjQ1d3B0VmxVRXROdXh6dSsy?=
 =?iso-2022-jp?B?ajlQaWpQUEs3Y05mTTBVMHpzWUpoODZzWTdyOWFEMU1EelhoL1phUzdC?=
 =?iso-2022-jp?B?WTUzeFRBNWVuV0YxTTFXUnhVMVRFbC9BZm1UWXhvYTdBZmlOdzMzNTIy?=
 =?iso-2022-jp?B?bjFPWkVTSjM2Yk9uTExkZjZLSnUvenVWNExEK0ZyT0oxcHJtRGVwaGQ5?=
 =?iso-2022-jp?B?NmkrVEg1ZjJxcHpzcFBydnRXSTA5VjJZUGp5MVNHL3UyeGxMSEZpeUF4?=
 =?iso-2022-jp?B?VHR6UXBVZ1FZQklDQUVNYW9YQU92cmR3c0Z0OHFtbER0blQvT0cxeVo1?=
 =?iso-2022-jp?B?S1VMcG52VVJaMVBDU2FpMERxUWUwZ0hQS3UvaUN1dEVBeERjRFo0aXFT?=
 =?iso-2022-jp?B?TFo5Q3c1enJQRGIvYWN4Slh4dVNKWjh4cGJIYnBOTHdtaXp3UmVETXFL?=
 =?iso-2022-jp?B?QThxU2xSRGxYT2h2QW9OS1I4dzZ0SzJ3WXZaMHVIbktvd2hzeUFCNWR3?=
 =?iso-2022-jp?B?bmdJRVlZZWxiaEJNbTdOZnNYUHhvMldjMGxSUDhERkIyY0l3Rmc1M3pK?=
 =?iso-2022-jp?B?SDJVNDRMTlhZbWxiakF5TjFSK283QjVGUzlkSGpHM1NrcldXTUc4bCtl?=
 =?iso-2022-jp?B?SWZmUzllVm1aY1llZFordUdkY2JnYXcvelpoOE1XQzNWeWx6MmFMOEsx?=
 =?iso-2022-jp?B?TXFadzEreml6TEhBeitDeUhucEdUcGZQNzU5eXBFOWZZTG5yQnlYOFlI?=
 =?iso-2022-jp?B?QVRmRlVBVGNqWDhsOWY0cjJlajZCWnYvdE1SQmlOejFWQnY2UkFtR1p1?=
 =?iso-2022-jp?B?Rk9LaS9nTG5rYzRFYXBwaUYvZHlKeWE5SzNoQVFjRUlYbk5ubUJENXF3?=
 =?iso-2022-jp?B?VkdWMFc1Vnl1WmZEemRHclBGaG84eWVNaWMyQnpFQzM1SzBBSmxUY01a?=
 =?iso-2022-jp?B?b29MR1BhZDZ6OXR4eHNVdk1reDNNOE90SjJDSHBqT2FVZXNINWNJT3Az?=
 =?iso-2022-jp?B?bjNlNU5zZ3pDeGJET25sUHltbWZEWFFXc0ErNm5VenVIZDJlbWhVMXpi?=
 =?iso-2022-jp?B?cUxPakVJS1dPMkJjaWhoM2w3SUJKREtySStVRlU1VnBrLzh0b0ZYUzBN?=
 =?iso-2022-jp?B?UWhlYVBsYzROTmlKd0o2dTVNUHAzalNXUlJOdjBDeDRCSDVWOCtlMy9n?=
 =?iso-2022-jp?B?QTd2SnBRWXYwd2pWODU2ZnNVczlsbW1ieTB1OE9VWktFRUJUbFdQTnN0?=
 =?iso-2022-jp?B?RHdkcFJsY3l3YUpRR0Zxb1NmZ2VmZEZDWk1oajhGU08xTlFmSUFwVlJK?=
 =?iso-2022-jp?B?Q1ZnLzhQUHN1RTI2alNmRkUvUXhFMGF2WXhRdTRra3NhQ3RBSTNUVzFU?=
 =?iso-2022-jp?B?NXh2aVg5VVNmSk9jWk5tZjNkb2FRaUJMMVVRWHV6NVBmZ3BnZzJpNTY1?=
 =?iso-2022-jp?B?eWJYaEpyWENialpMb3hCZ0Z6OGwzRnJzc2M1VzdEMEVBUmozbkpjUmxK?=
 =?iso-2022-jp?B?bWoxSE85MlBDcUlraDdHMXgxV1ZyRmd2S2M2NGkycEpYR1JHRi9GU0d2?=
 =?iso-2022-jp?B?bjdMWkcxQ21TR3ZDL1Z0TVZTa2FkeW5xaTBnQVd0d3M4NUgwSTM2OVk1?=
 =?iso-2022-jp?B?SFVDaWpXYXRHRlZHK2srZEZPNnQ5Um91VVFwV0laU2NndC9GWXRINkds?=
 =?iso-2022-jp?B?am1FM0pYQXpKQ05GRkQzVGRvNkUrTUNVdVZDdnV5TXVIZTVGWVNnQm93?=
 =?iso-2022-jp?B?ZzVjYUI3cG9LV2RibWFQR0o2Vlo1MXE2L2d3OElESCtMM0VZUitScnpB?=
 =?iso-2022-jp?B?SVVkZzFzZS8xQ1pKQlpmR3c0bW4vQ3RxS1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?S3B2UkdTQmxkSmhnSDZZUUZRbmQ4Nm9hQ2Rza2pxZzZWQXdjYkpTckRL?=
 =?iso-2022-jp?B?S1FIWGxYWWlLTkJlaGYyV0VkR2pWOHpzSVFCeWk2QUZnNTQrK1FKZHlo?=
 =?iso-2022-jp?B?TjdUa2pOV0NRU1VRWkRoZktpYTg4N2FOeE8wUW9uSWJGTFpmSlFxbWd4?=
 =?iso-2022-jp?B?eHd0cE81bk43bUt3bkE2MlhDeU8zUFRPaC9PSU5ZclF6YzlqWGV0NzJV?=
 =?iso-2022-jp?B?YmlSQldoMUlsSnh4ekpOQTA5TVFFUGhYTVY3SFFqZzZGTzBhRVJzSXh2?=
 =?iso-2022-jp?B?K0NIM1hlRkhhNyswcGdYMmlBMUttTTRBTERvODZrSU5ycUlqdE9mVDRx?=
 =?iso-2022-jp?B?RCtaQjhZQ1VyU3ljNHZiMHZzLzVNUHNqc2JTeDV5VjNsajhiNWQxZjlK?=
 =?iso-2022-jp?B?cG1yZHVTQU96MSt3S3hYcExzUkkwU3BkZ2licFc0YU8vRDZMS0VyTHE3?=
 =?iso-2022-jp?B?QStGeEtHaGc3UFlLNkg0Z2lKT2UxY1hKUGhFSjZJTzNla2ZoTW9scjJs?=
 =?iso-2022-jp?B?b2YwekpHa29QQVVCc0U0WXNQTjZHdTlBSDNsYUxGelZvcERtNFRSZ1Rk?=
 =?iso-2022-jp?B?Z0crVWNZeDFpSzlwODdCeEdaL2dQTnU2WVhORk9wL3VwdVJVNWVoV1ZZ?=
 =?iso-2022-jp?B?ZnhBM2JnNC9yV09Ja1A0R01ndVBYNEhiUURMRzFSVmlRWUZwenptMWFl?=
 =?iso-2022-jp?B?OEJacnZtdVJPNG8wZlJZQmkrbkloa0VDdmEwaEpHWEhGSFpveU54SGJB?=
 =?iso-2022-jp?B?Y1M3U0tyYlZnZmZtWURXbkVFM2dVRDRtMTBJRkNZbWxudGdWUHlzazFR?=
 =?iso-2022-jp?B?UjVhcTFOYkc3OUFIdmk3aGFGRTBhNmdXUDYxbEJuZ0pOeGluRTc3MGFi?=
 =?iso-2022-jp?B?V3lyd2Jja24rbW9UVWM4ZkdrVW55RlFDak04MC9DLzJZamZQRDJrTTdo?=
 =?iso-2022-jp?B?Z1BYSVAveHh6WjVONHBOT050ZHhnTW1xSFoyME9ZSG95dm5COTRCRWRv?=
 =?iso-2022-jp?B?c3d3N1hGZlpxVmhRSnNyVy9udDFSclJ4QmxpaXFKMjZRTy8wWFlCbzB6?=
 =?iso-2022-jp?B?UVNNZUFkTGdsR2JqUVRJelIrSmhuUUlvd21CWHpYSUNwM2hUbWVDNkF4?=
 =?iso-2022-jp?B?UU4xMHVaYnh2SGJXVE5EZlc2amdwN0pUQnNMZnJOWXkyMGNCZGpBZXl5?=
 =?iso-2022-jp?B?bXRvS0pMbzJKUzg2bHc1ZDdZTGJ4MXVMS0JzYjg0bFFSbERBUlVqLzAv?=
 =?iso-2022-jp?B?aU5XT0NCVERzS2ZiR1d5VGJZQ29NajlVNEJGZEpHT1dSYy9WZUtONEJZ?=
 =?iso-2022-jp?B?ZlQ4aUlvbGZKbXdOUWNtOXdBSkZERG1hUVJaeUw2endBUGhhTEw4MW1s?=
 =?iso-2022-jp?B?ZExPd0tneWd6TXFhUXRNQT09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6f63a3-8705-412f-3408-08db9140a4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 21:05:02.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPiYgK8neQkMdSFBkR6st1URsdorUZDH2QQJK/TN7YQUF33N8PSytBJtjPlUr6Ouian3TSrK9wA47LCJwxJ6H2mvo7KA7XuKRqW9bqJkUYo//5vU0mZiJddq6l/zviO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Jul 2023 21:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12522

Hi,

CIP kernel team has released Linux kernel v6.1.42-cip2.
The linux-6.1.y-cip tree has been updated base version from v6.1.38 to v6.1=
.42.

You can get this release via the git tree at:

  v6.1.42-cip2:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      0d2ec524c820bab8eabc0f1b34aa41ff55d4e9b1
    Fixed CVEs:
      CVE-2023-20593: Fix Zenbleed
      CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads =
to use-after-free
      CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_e=
nqueue
      CVE-2022-48502: fs/ntfs3: Check fields while reading
      CVE-2023-3863: net: nfc: Fix use-after-free caused by nfc_llcp_find_l=
ocal
      CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid
      CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write
      CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference
f2fs_write_end_io()
    added commits:
      CIP: Bump version suffix to -cip2 after merge from stable
      pwm: Add Renesas RZ/G2L MTU3a PWM driver
      arm64: defconfig: Enable Renesas MTU3a counter config
      arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
      clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
      pinctrl: renesas: rzv2m: Handle non-unique subnode names
      arm64: dts: renesas: v2mevk2: Add PWC support
      arm64: dts: renesas: r9a09g011: Add PWC support
      soc: renesas: Add PWC support for RZ/V2M
      dt-bindings: soc: renesas: Add RZ/V2M PWC

Best regards,
   Nobuhiro


