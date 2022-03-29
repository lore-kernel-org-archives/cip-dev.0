Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77666C433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 09:37:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.4723.1648546631818307117
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Mar 2022 02:37:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 22T9aolg029118;
 Tue, 29 Mar 2022 18:36:50 +0900
X-Iguazu-Qid: 34trWdh3LUPxRO2vuz
X-Iguazu-QSIG: v=2; s=0; t=1648546607; q=34trWdh3LUPxRO2vuz;
 m=LS8A7kwjSrjAGvnJH1TVodRHV/5MsUtRmMGu9EkOegw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 22T9ajYb039966
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Mar 2022 18:36:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wax6bQz0w3NXmAEpBsBnWIpep6fJ1bVYE7elIQtz0OYOHTkzTSEbB1gnFqhwKzEkyk5cY6QwAafNsxT2nEO8hGVkwVGZmlisYnUkp1OLqBTHbqlalqm3ahAM0yrL97cZ0YdO15ILZbPNOnLqWu8eQlMv9Bvk5yb56WneXTRHuaactzCIgWN7NsoCUSb1nZWTJgLfrcRr5pUN7TAycJdacWsz9X8gPoMRsyDGezwLGByIuocNnUNeUg4vpKfd2MMs1eg94STpFVb8IgjDfOZ9bNxKWhKO7OZ8Tw04lHDL0whA+J/vBDBOFlATPZmeqEd4jt1kwtANwdASkuQjBzsRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU82MOx+mOvaIQukPbVf0ekd5BUSrGcrOylHwd+8MGE=;
 b=TNxlftr9zlXKoe7JjkC13ywnsFeEmfs26QJxMQ0SBpgeC0+RYcu+8MtoKzAVIkEuMHS74ap8fLyCTcm7N4ZT/4Z2uhfvrblCUK2pdFVQ8OWlS2CxfvMXUEg/MP4A8zdSIEljNz0kEMwjkYbJet2QQ0BRM3dinSXDBk21ZZVPMfXTyPYFsp+/fQNr0X2c0iDKNFqhiH4di9xijIIKZopar/7GLZqXH2JxKa7n6SUtkU1XxQqlffpU9y5q87jcdg5xnXAR2JVaFzNVg5MBqUNoCOmmEJZB6RWLH++CA5Tl66Y+hDz/OHiTilQab4NvzFwqOzy5uXCFN74BkRA/N2Prdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.106-cip4 v4.19.235-cip70
Thread-Topic: [ANNOUNCE] Release v5.10.106-cip4 v4.19.235-cip70
Thread-Index: AdhDUFtbtLOREx8BT1qKVFuXaBqAKw==
Date: Tue, 29 Mar 2022 09:36:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625292845F0E040D7DF9AE6A921E9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07af7b31-e6aa-47d2-3cee-08da11679f89
x-ms-traffictypediagnostic: OSZPR01MB8500:EE_
x-microsoft-antispam-prvs: 
 <OSZPR01MB8500B47E844DF0D10A5C659B921E9@OSZPR01MB8500.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +NodNzJEqKrbtLJLfyf+E3zxzFheAkqOl6qQAyFD6+P+mKEa9VzVDiifq6v6ttvoZvlaEVo6ee2vam+f/zlIDeRg5NVH2Jq5mV9GoHn0nQgKbJl+CB2wtQGe83g6hIn3myrIv9eFvI3gXv6nkzeITPwMBRHclP5WVOYwSuauSOXkR3Gz2i5rYsqp+oM+TXXWsza9MkpTOjF20Uua98rGx50WNfTgsxo7pK3pjoSLMDaNTclTgVLDKvlSwPxNxL4Q1Tum3USPHfGZy3U8u5AKDAlfof1leEf7RotUcWotI0R7vDex+UhrOVg+7M9ewT8RgebM8oS2jbZpi/2BIzMsRClrt4JMJZNRn1sARO2XD0bx92844ri86MrP716bECxtAgALz6jvoIKcXxoy0UGCvEMv574ns+wbG9l1ktxaAWyzPveM2WGaU2Ne+QeXYDSA4mZEomHZwUT0NPyONsnrYFATM/2mPFNHG2a/OscfnZxH0tOqjuKQbx020ZqtbnMZaj2c8pG3/o9eC/ge6qmeNyuUD4PefezNkpwwaIguw90Qzu26biQgCMhj8BJ0OnF63a5KCaIhVKBNBz3hiyrEygkCfefgIDXkxEfDcrVH1DUqQfdezbVdXiDNq4SIVJiWvIvcLOQm9ZpUcw9HkxOa+fe6LgxbbZFpddrEJyLIxPo7UwUP8fVgl6gAimtWvTyST+V5ql1ryAdOWCJZzyyxsguWJs1WBgX3bay8irvyX/nyJxXRPJAoM9NxaVMHP2w2P/Ytd1LU0UZ6W+CGrIDCWaRF87B2e9uSdPpmTueydw0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7696005)(38100700002)(54906003)(55016003)(6506007)(6916009)(186003)(8676002)(71200400001)(38070700005)(966005)(55236004)(26005)(508600001)(86362001)(316002)(76116006)(66476007)(4326008)(9686003)(5660300002)(83380400001)(122000001)(66446008)(33656002)(64756008)(66946007)(66556008)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZHM2TC93eWZlS3l0L1kzR1VRbTh0ZVd0M2wrVmhWdStqR3BCZUVoWEMr?=
 =?iso-2022-jp?B?N2pHU2xqVWthNHFuV2hWZnB4cTlCM290c1EyNmQrazkwdngzaHp0SFdr?=
 =?iso-2022-jp?B?V2Y1UjBFMFZwNCt3NFJKK1c1aDlETzQxZGtURmh5NlN3RUEzazZ2MzQ3?=
 =?iso-2022-jp?B?TkVwcWFaalhWQnR1ZDN5cnFudGw2NWhZNEI4OHJTZlFLSi9MdmJNOXlW?=
 =?iso-2022-jp?B?NkFQc2FWSkF4WkhtQkxjeDJYbzcyNUlEdmZVcG9pSmlLaWtKb24yRTVZ?=
 =?iso-2022-jp?B?cVJ5K2lMTTBPRGZYZHIyOUF4aENSM1NNMUpuQjkwK3N6RUN1aXpsdUpq?=
 =?iso-2022-jp?B?dXNlSnloOTZpUmVUZnk0c2NuNEFVMUNVRFpCTmNkOFcxTnJXUFRMcmZp?=
 =?iso-2022-jp?B?dFVFdytZT1dtalZqdjdsWWhRY0tMWXVSZklxWEZPMENFWlI5WEZra1pG?=
 =?iso-2022-jp?B?bEtCeEFOa0NOa01tVWNTV0JjcER1akxIQXVLTWtSblFOZ3BnNDNnZWZR?=
 =?iso-2022-jp?B?SmN5RnJFYWpBTUhCM2ttelIrNnlVUWxXckwvdS9nb2Z3QkVVdjFib2JW?=
 =?iso-2022-jp?B?elFOeHJKYWw0Q2dWRm9lNUNTUEJQZjUyUmNtLzZSOFE3Njg3aHJXekJl?=
 =?iso-2022-jp?B?QXFtQ1pjUFBwbkhVQmhmV1BXaVVVZy9yR0JJNE0vN3c2WXQwZlJJUXdE?=
 =?iso-2022-jp?B?UGFEbUhpaDdJS09Iamo1REJvWStUOHVhZjltRGZHM1EwVTNrQmF1WXpq?=
 =?iso-2022-jp?B?VFAxbVRNQnk2V3pJd3JaTTg2VlE4TVA5dTJyRHpqWS9pNXA1R1NLSlM1?=
 =?iso-2022-jp?B?SU5mZXpDanVIejFVZXAvRkhFQlBzdWNnTnRlR0Voa09aTkhpZWhaYTk2?=
 =?iso-2022-jp?B?cno0enRqQnE4cUxBbDZGbi9FaFpRWGF6TEcra1ZyTnNZMmo4M05qdFpj?=
 =?iso-2022-jp?B?RDZiVFFjdnRRTjEvUEdDWmFtT1BNeTJDKzVrSnI1RDhFc0ZQTURFajhs?=
 =?iso-2022-jp?B?WXhvRFJsakttODlLSEVpL3F6VDlieTZzMmFKekt2bWYzL21sUnh2SFFv?=
 =?iso-2022-jp?B?dU9hMWhwbldwT2Y0RkJ5TjlxT25MUFdTcEJVb2hQSk5YenJHbFRhTjFU?=
 =?iso-2022-jp?B?aUhpVUcrM2M4NHh4WU5tRVkzZ2pkVi92SERibTdBekI1bmEyRGFIcGNu?=
 =?iso-2022-jp?B?eHRtSEhNdVJkbitLejRVSE5RR0FvU09aeUdEK1o2ZEVnVkxaZXI2WXZZ?=
 =?iso-2022-jp?B?WWJKVVRYNSs1QldnZUcyNEdZVTBjcG44SlhkamxFRWs2U1VOd2pja0ZP?=
 =?iso-2022-jp?B?NDdlSURuMVkxYzV1SUoxTmpZcTBRNWRvTzNxWEhLNlh3bi82NGt4cEV0?=
 =?iso-2022-jp?B?SVR0aDhYNGRJeU9BenFkVDMxelgyOWJaSnlsMUc2ekJiUjZzbVM1cCti?=
 =?iso-2022-jp?B?NUEweTJnM041dU5jbGlBM3NLRUlNaXdmYnprS3NraHhwZGt3UWovNkZk?=
 =?iso-2022-jp?B?cTlhSlVEUFlBc0V6dGpqeHdJNVIxN2U3bUxnRktLMkpxUkk1aEZyQ1dr?=
 =?iso-2022-jp?B?L0dXUEg1YXNSTjlNZVMwS0gvd0Q2NVQzSE1lQ2VWd1FGRUJHbTQ0MGJD?=
 =?iso-2022-jp?B?S1N5TUNBM25Eb0l5dGdSV2lxazFETjdMS1psY0s2TjliaWptTVhRRHFG?=
 =?iso-2022-jp?B?Yml0dHJqMWpNcG1JRTRNZGkwb0Q5Wk4rbnBiQklrNlUxRmZUMWxpWEgv?=
 =?iso-2022-jp?B?SHN6ZmhDOVB6aEc4MEhUY1dLYjlIMFgxTC90OXU5bEQ2SHhZTnZBWnB3?=
 =?iso-2022-jp?B?UUd5LzMyeVBBRkxxNzBySEI3UVgwbHVvVXVOYjVpSEFIaHdmaEdBSllX?=
 =?iso-2022-jp?B?Wkk1N21ZWERvRndrSGg2bXZmaGxyQ09za3hiL2lZMWdyUE5rdzc2QmZh?=
 =?iso-2022-jp?B?QlJIL2szbmJtQUhQT01yQm9WSStRR3E1YW1SMXJiRUhCZ09QNmhhWHgv?=
 =?iso-2022-jp?B?bkRVRUlxTGZ4SStLeXEwdXFlcmFOdHE2Y2lCMlBnT2UzQzdjOGp3cHFD?=
 =?iso-2022-jp?B?TTJiWitTVzZ1MkJMRXFoRDBBelM4aUIzbUZuVnBVUFFLeTdTUUNtMHVZ?=
 =?iso-2022-jp?B?a0NEby9rZ0Vac2k5anMza1drWDUrUk1leW9TZTlTeDJOTFYzclNzQnYz?=
 =?iso-2022-jp?B?dGlOUmtRWFRuZzdGTWROeklGeEk0Yzd4QUt3ZEtaUjg3STNicitxTC9N?=
 =?iso-2022-jp?B?M1ArbzVQaEhPcE84YzZiUTRaSldkRTE3bWV0OENNek9SL2tFWXpja2l2?=
 =?iso-2022-jp?B?SXhWTnR5ZUhwRzVaYXJUbGhMWktLUEtCU2xuMHVRelczYzBqalFqaXcw?=
 =?iso-2022-jp?B?YWpTUXFHc1JsQWw3UEw3RXBaUEhIZzg3d2VsSGNGb2Q1ZG5wb2pydU5H?=
 =?iso-2022-jp?B?d3dRZTNmRU90UFJVMUlJVkJxbjgxdDY1bXIycXE0ZDhuSDZkU0FLRmMz?=
 =?iso-2022-jp?B?d1VmYzBJK0ltLytxMktyQ2RIVjZnTnlDRFpuNGI1YjZoYjR0cEgrU0No?=
 =?iso-2022-jp?B?THRpcFJ4TT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 07af7b31-e6aa-47d2-3cee-08da11679f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 09:36:38.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 8WWNFDnGJEEZQ5XRlKuRuNXJuzMnko0F9LpXauTwMgZlpROnwK5tn4Wg7db3ePALoemS6xFC0x6No9HaJfVSW6lGEc/9gkXhoGnv5haIMSp39RTt7yMerle5J40qE5wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8500
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Mar 2022 09:37:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7838

Hi all,

CIP kernel team has released Linux kernel v5.10.106-cip4 and v4.19.235-cip7=
0.
The linux-5.10.y-cip tree has been updated base version from v5.10.104 to v=
5.10.106.
and the linux-4.19.y-cip tree has been updated base version from v4.19.233 =
to v4.19.235.
There are no CIP-specific patches in this release.

Yoe can get this release via the git tree at:

  v5.10.106-cip4:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      8bb6e30b765989a3c0924158316d689e16317cd1
    Fixed CVEs:
      - CVE-2022-0995: watch_queue, pipe: Free watchqueue state after clear=
ing pipe ring
      - CVE-2022-23040: xen/xenbus: don't let xenbus_grant_ring() remove gr=
ants in error case
      - CVE-2022-23036: xen/grant-table: add gnttab_try_end_foreign_access(=
)
      - CVE-2022-23038: xen/grant-table: add gnttab_try_end_foreign_access(=
)
      - CVE-2022-23037: xen/netfront: don't use gnttab_query_foreign_access=
() for mapped status
      - CVE-2022-23038: xen/scsifront: don't use gnttab_query_foreign_acces=
s() for mapped status
      - CVE-2022-23039: xen/gntalloc: don't use gnttab_query_foreign_access=
()
      - CVE-2022-23041: xen/9p: use alloc/free_pages_exact()
      - CVE-2022-23042: xen/netfront: react properly to failing gnttab_end_=
foreign_access_ref()
      - CVE-2022-24958: usb: gadget: don't release an existing dev->buf
      - CVE-2022-23960:
    added commits:
      CIP: Bump version suffix to -cip4 after merge from stable

  v4.19.235-cip70:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79
    Fixed CVEs:
      - CVE-2022-23036: xen/grant-table: add gnttab_try_end_foreign_access(=
)
      - CVE-2022-23038: xen/grant-table: add gnttab_try_end_foreign_access(=
)
      - CVE-2022-23037: xen/netfront: don't use gnttab_query_foreign_access=
() for mapped status
      - CVE-2022-23039: xen/gntalloc: don't use gnttab_query_foreign_access=
()
      - CVE-2022-23041: xen/9p: use alloc/free_pages_exact()
      - CVE-2022-23041: xen/gnttab: fix gnttab_end_foreign_access() without=
 page specified
      - CVE-2022-23042: xen/netfront: react properly to failing gnttab_end_=
foreign_access_ref()
      - CVE-2022-24958: usb: gadget: don't release an existing dev->buf
      - CVE-2021-4149: btrfs: unlock newly allocated extent buffer after er=
ror
      - CVE-2022-24958: usb: gadget: don't release an existing dev->buf
    added commits:
      CIP: Bump version suffix to -cip70 after merge from stable

Best regards,
   Nobuhiro


