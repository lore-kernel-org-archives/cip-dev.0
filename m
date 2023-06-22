Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225DEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 04:44:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.4566.1687409047030543962
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jun 2023 21:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 35M4gnMS030699; Thu, 22 Jun 2023 13:42:49 +0900
X-Iguazu-Qid: 34ts1GHAezWfB6BRVk
X-Iguazu-QSIG: v=2; s=0; t=1687408968; q=34ts1GHAezWfB6BRVk; m=dopCyLDN8Ttq+6vkUAkwPR5y86/S0Z7S3fvgUobX5qc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 35M4giV0012236
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Jun 2023 13:42:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx8coQ9To+b4xnisobI4TchioSkFgJSCRxIXVK8W/XTaQ1bXoQRbl/FHOGJ9UVG0XKTJBtPTFqBEFhcxrjMPEkJFGCR5n9qP7FM/US9gUOBo9dFBDq7uOMJoRnNkbIIGj3v/Cre8CL2WZjj7KE4I8nlmpKImDxdBnSkMJWXm0a8c1zoZOhT/kL20h5eKI2zpy69OblAL5pcqY9c1g9Wzw7f1vRpyBw9vzHXtxkPIbn645Dpg+B1P7VlDCg9Vvn4UDWa0gMz+MDgTFiF+ntpvtiajjYziZvMp/yW6NfkIdWBG8KPL6GOrq3VECDihXpv5Np/+93Iqhw4Du7IDrMpeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5Wimy1rfPZkzn461Awoayjz2WblOiqVHBnpLgttgL0=;
 b=XrijeRUbKGBN171iyVsqjENrdPA0uEax+sN51nNJkzyRTmupw5CVhyoFQRCbXK5j6yVvozr+dHfRq9UX1eagWmW+RTq28Awa/mwOmz9sKlXXTHHt4X5S6+3b3NP2d3Nlh5e8onW7G6vfPXMKg/29lGtoiIU/X0mOeXNkHgie/Id9lXNEPZhGe8Jwv4U94nktBEeUw7dwzkdymyTtQC/uyuAy+OkYSRS8ozzdbbrJyW0TS8zDzrjF5qMHWb5caxQfTDvteUgZIDyeYqACxo56Uhcujkawb7FAz+EKwJ0s6ReZ7kdBnO/+UI/wZg11FyBX/DSNnIvSlDYyW6vMuNuKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.184-cip36
Thread-Topic: [ANNOUNCE] Release v5.10.184-cip36
Thread-Index: Admkw9q3a9UALWPhTAGMcPEQQbb6pQ==
Date: Thu, 22 Jun 2023 04:42:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A9D1236A1201A2259F4E9222A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB11621:EE_
x-ms-office365-filtering-correlation-id: 1b83de9c-1984-4ce4-7df7-08db72db1dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rh1q6e6V6IdUefcWCq4YJq1toSIsYkHInxT0l/qlVb2sI0kRElkKuI/MgurX7F+sby/I/gbXcj5vXlzhPln293h2QVp13LeCMD9BAP+2In5fzqpwpw9uiZJSbjEenHokHkigcaFiETc1pRRvCsB38BgvUqDHycHcCC9Xq2jbIU8Tb9QkSdZUrFjppT5mKwhH5Hi4asE359gHNagRgnUyMNQHW0Ojt99EZJcXB7bbzsTavUfH04IMSVuIYvz4/10HZhykj1nuhb3MDjK5YrEkI6tQws92hQQZuuH6JWa5dNaxIwAABDEpbWa/Y7WvPvpvAZZsR7W3Ymv1zwf3JpMASQ+IvtyLoOZC/GKlpcu8DZ+5YN0NXTsMKGhJEhswarR0Uz3zocAWjoKtK8qVuLW02NdwO1Nz8unWw8YVJQk0EOt8WoICLNOga0qN8wFP103PSaz0+69Y+6jFd0vq8xx/N2ALfR9NFkHXHP1IuFTfJ0Yip6QERW2nmbff/UOje92eLCE/ur/I708vSdPIj3IVyz4ptNPfgrq9wu8OUVEABObS5pA+on1/5aNIen+JXCY/NxFBIJtePhz3RjZYLSH0mCpMpjv4bmiZ+tNozM02zBubgE/4xXeoSXU6a3jgc9sNrLm/m2LD1xB+4Z/jEZFSgg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(66556008)(4326008)(66476007)(76116006)(6916009)(66446008)(64756008)(66946007)(86362001)(122000001)(2906002)(478600001)(38100700002)(33656002)(71200400001)(38070700005)(83380400001)(7696005)(316002)(52536014)(966005)(41300700001)(54906003)(5660300002)(8676002)(186003)(55016003)(9686003)(26005)(6506007)(8936002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VnlScVNMWlI0TTJGSjFOdkJURzhGd1pTMktLcEJaWjFqam1IeXliUkp4?=
 =?iso-2022-jp?B?REpHams1QkxmUUNWUTNkL2NJQklVV2VXbDFYZWFMSzRtZHdCR0xrY21p?=
 =?iso-2022-jp?B?QjUzUkFpU2lKRnhEQUt1RlNrM2gyK25Qb3Uxd29nT2xuZ1hzODBTN0FB?=
 =?iso-2022-jp?B?NEhNK1l5QkpqSlhBbXV3Q2o3OEh3OU12YzQ4QU9RSmFYZUtaTzJEdjI4?=
 =?iso-2022-jp?B?N3IyZzgzL212UXpqYlJtbytIcGVtTmkraVNOeUJIakhBVk4rcFJHS1B1?=
 =?iso-2022-jp?B?VUptVmJ6aEZJZFBHdXNkZzcyUzZoWllJTzREbEVhMURWb05aMXpSTDBM?=
 =?iso-2022-jp?B?M2U2S0JDdmhvbDg1UmNEcGVsSzZyY0hBM0NNRGRBMmQ5MkR0Z2x1L2Mw?=
 =?iso-2022-jp?B?UGcyazFnaEh2MnVtN09CSzJhZGI4djIyMXdBK21XVkhnY2NJK2hQRXRM?=
 =?iso-2022-jp?B?eHBwRE5yQittbXR2QnZPaE5yRjhxR2VGUUd1dkxpR2x3R01qU2tKUlJy?=
 =?iso-2022-jp?B?cEozQnNPOGZrVDBOMC9wOFdKRjhpYXUzTTI4MzNPdmswY0ZycEkwOE85?=
 =?iso-2022-jp?B?R2ZTa3hENDJnUk1obnJXMzlNM3N3NzBxeEtac2VxL0hxQXlabFVsNW1E?=
 =?iso-2022-jp?B?VDViQ0luZmxmMGxlWHRKcXZ0KzduZkpWWjZIelFlbGpTWCt6aGQwVUM0?=
 =?iso-2022-jp?B?TDgwQzEwYmhHM3ZBSWpldmtSYXlSckoyN3B6WjJtT215QnJESXArVkZp?=
 =?iso-2022-jp?B?MmF2Q1hDWU1YY3d3UUhPaytEYW85aWwvcVJVUWZpc2JIQTVqZTlzT0gv?=
 =?iso-2022-jp?B?QiswNGZBRGJwaFpBMkpmS0F2a1Y0dW5ZcGhCQWpiVnNGQ1FaQ24wNFox?=
 =?iso-2022-jp?B?OGxFcTBUUGtEbFpramNjcHlHdWE5MWo0dTJLZEpyVkhNdnhDZ3dFQ1pw?=
 =?iso-2022-jp?B?LzFxK2txODZpNHcrTjRieTZxWUJJeFgxaE5YSzBqb0RxcU9nZFdyaUJJ?=
 =?iso-2022-jp?B?S2ovZm9HQVdYUnFXbFRSaVFTWC93ZFpPODdhOUU2dFlKTGU0MDFMZ09U?=
 =?iso-2022-jp?B?V3h1aVdOS3hQbWdTRDkwbEJQS3dSU3cxa2ptYXRkbU1QVXNCRXMrV0ll?=
 =?iso-2022-jp?B?VklWM2tJTWFlSTBmYnN5T1NZanlwTElqMjdrSHV6RDBreitScFhKWUZz?=
 =?iso-2022-jp?B?cjN2cEpmYWZ1aDRMU2wzYVRjUEZ2UVU5UkxiT1piRmd1Ny93UzZsNVdq?=
 =?iso-2022-jp?B?dktkNWc3UjVPS2grMWhTZDZ4MGVxc0NXSE5DWmUwQ1NXODIwVlBjUis0?=
 =?iso-2022-jp?B?eXNUVGVOYUtVK3VkdGo3WW9mcDFKb0IyckRqbkpBT2orK09uQ0c3bVJJ?=
 =?iso-2022-jp?B?YWpxTEsyYmNnRjN2TjY4d0c0QS8xajF4RFdYVFI4NWZ2alJNblZhZklw?=
 =?iso-2022-jp?B?dGFJa3g3TFFpTjhwNEdSNFp4Z25waWdvWDYwS1BCQXhoL2xnUVRDa2VW?=
 =?iso-2022-jp?B?cmQ4dXpydmJQc1dnWC9jcDkzN3dvZHVhTk5BeC9SSm9UelNMQjM4WHNn?=
 =?iso-2022-jp?B?MGkrNU9TeVdpRkEvalVXNEpQL2s3YzVpdTViR0l3cm5ZOXFRbnRYbXpx?=
 =?iso-2022-jp?B?Q0lRWmFxeXZYc1BtQVc4WVl0Y0Z6aXpjbHFUYTZ4QUFGZzJKSU5CN002?=
 =?iso-2022-jp?B?WnhVd29iby9RL2hSOVB1VGp6d3JjYkwybUFBWExBa3pyL2gvYmpaY3ZS?=
 =?iso-2022-jp?B?OXBmeHBwY0R5ZHFvR0xrOXZOOW1XclVVUG1BL3hBeW16WkRUUXZ3L05h?=
 =?iso-2022-jp?B?TkdXR01SUTErbkIrcDJQZTdKakpVLzdKZkRlZTd6RXJxWnZQOURTOVAw?=
 =?iso-2022-jp?B?TFdkcFhhejkvL2tHY2FZZ0pVazZtS2lCWWhnSTJsWlJaSjE1TUFaRld6?=
 =?iso-2022-jp?B?M2R2NGgwWkhHTmRvMGIyeHhOelYxWHdqSmxEdythcHdBWlFMSTNFWWRX?=
 =?iso-2022-jp?B?WDhQZzBZM0tTMDcxQVlFaTJUNzIxeW4yK1B0bXJoL1hreDE2UXREamFY?=
 =?iso-2022-jp?B?Si93RzlocVRyWGlueEdTdDlhRnR1WWFDbkdOeFNib1BuejlYVmFxYjBY?=
 =?iso-2022-jp?B?RnRVWUxKY1JxTGpmTERSMFNtQW1FamRhc0JXbVJ1LzEydFB3Wk04Y0d0?=
 =?iso-2022-jp?B?Q1BLWHlldU9ERFdrQVdhbkwwRWVvQnZ0R1FTSVBNU1hPYndCYlZQVHJC?=
 =?iso-2022-jp?B?KytLWGVhU3QyaUpaSWpicU5lT3cvcEUrRFJXcU14ajBJeElkMWJzL2ZJ?=
 =?iso-2022-jp?B?YVcvQXl1bEVsMDg3OTYrSktGNFhWV1pDOHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?WTI2REg4OE94SnNiUTFHREVvZ0cwWStzQ1g4NWkwUzd1bVAzeGRnUkpz?=
 =?iso-2022-jp?B?bURZWXVRTi9UdmtFaVNhUkVGNWdJN3ZBSzVIMzRWVUYzV1BENUdMbVVj?=
 =?iso-2022-jp?B?VE1sSEZSNmxqdlJMdHRXZnB4Y0hhZXU5UG45ZzhtQlZkYVRqaWxRcC94?=
 =?iso-2022-jp?B?V0NvOXBhSUhKZ3JyYkZwczBhMVh4bk8xdlBIanJTakZlUTBZZmZuOUl2?=
 =?iso-2022-jp?B?L0pIakVlT2V4UmdhbXJQQm5MM0RNMk9YWGpkY0ZoUWhTdDFudWNhT3hy?=
 =?iso-2022-jp?B?TTByOXRDRzFNV0tWNS9GT1BodlViKzR1U3MraDBSS3FPRnNPVVk3dHZQ?=
 =?iso-2022-jp?B?Ulhkd2hEWmdwZFhmWFkvcWswV2FYNGUzUHoveGMwVUJuV3BrTGFVTmt0?=
 =?iso-2022-jp?B?YmFKS21zMmdRd2pHYm5QMWRNcHJ3TFFxYTBZSzg4K0hDbUZ0UU1XTGNZ?=
 =?iso-2022-jp?B?bDkrQ2h1d0FqUy9pdzl4cUtjclJwYTBmdFh4clhwcjVBZzUyUllLS0Jm?=
 =?iso-2022-jp?B?aWZPcmo2eVVWVnd5YmNwVzZGRDhSY2VlblZCOXpaMTF3VHdmVkN5ZlpK?=
 =?iso-2022-jp?B?bElES0VSWW9BZWgxZmxnQmVoekxjV3FxN1hWNDFJbmxjZ1RLRitNNVJU?=
 =?iso-2022-jp?B?QVZsWUh2TVA4ZTFUMU43QkRnMjkxaTBYWEtHSTFzNW84Q0MvR2tpZFRM?=
 =?iso-2022-jp?B?dUhHYUFHS1c2K2U1U1ErMjZIV3J4eGY0Z1owNlVzMlVlYjVoZlA0eW43?=
 =?iso-2022-jp?B?anBrWXFOZ0pwVktpN2J0Y1pBR2ZOZEt3UUhmQ3pFM2Q5Wm11T2V1bkRo?=
 =?iso-2022-jp?B?OStqVjVWWTlGMklrUkpQK0RFSjNmMnZ6a0h5aXBWdENQcUNsVjFUR3Fy?=
 =?iso-2022-jp?B?R1dWT0dTRXprUG9iQ2dyMThTSWc1YzVNVXZvT0ZpVzZtZTgyQUl6b1l2?=
 =?iso-2022-jp?B?azh4K2lvVnFvc0RTSldsa1dXcjZiTUFCVDRiTVdLU1hVMURvUytySnE1?=
 =?iso-2022-jp?B?L2libEU5UGhaM1pia0dDR3cySThscldtSzVGdk1hdEF1UEZoK3pFYTRG?=
 =?iso-2022-jp?B?NUd6aGRjMkxqL25mQU5CQnAvVk5ZYUhSeWdQNnpoc0prUHBISktYV1hx?=
 =?iso-2022-jp?B?dFN6TnJtT2lSUmFxSFNLeUVVTEkrMHZyQ3BNbHdNandKZVd6UVoxc2Vh?=
 =?iso-2022-jp?B?U0tmUmV6Z2FMRVYyMEx4RW5tRU9RdWJFQVlVbjl1NkdtNVI1dXN0ZEdu?=
 =?iso-2022-jp?B?dm5CSlRwVFRCWllSMSs3bFlOeXBPYk1yRjYzR0xCaFFEd0p0L1Nla3Ji?=
 =?iso-2022-jp?B?Vm9FbXZ4V2tqOEZrdkJ5Q3ZLMS9zMFRmeURFN0xuL0Z5amdSeFJCam93?=
 =?iso-2022-jp?B?K3NadTM3ZHlnVTd0N3B3UT09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b83de9c-1984-4ce4-7df7-08db72db1dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 04:42:42.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6AdE7PnLB9I0o0OVkbnICWxsdz1JHloZXtbkoPZA5ulGkt02zMmG5DsaqQiy+mIYNEv8e3QaIh8cweWeYeqGWpycHKrkERMoYbP0ZySYqxEXNZx3gDcdlRknGaK2pgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11621
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 04:44:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12113

Hi all,

CIP kernel team has released Linux kernel v5.10.184-cip36.
The linux-5.10.y-cip tree has been updated base version from v5.10.182 to v=
5.10.184. And this release includes fix for the serial port used by Renesas=
 SoCs.

You can get this release via the git tree at:

  v5.10.184-cip36:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333
    Fixed CVEs:
      CVE-2023-34255: xfs: verify buffer contents when we skip log replay
      CVE-2023-2124: OOB access in the Linux kernel's XFS subsystem
      CVE-2023-3111: btrfs: unset reloc control if transaction commit fails=
 in prepare_to_relocate()
      CVE-2023-3212: gfs2: Don't deref jdesc in evict
      CVE-2023-2007: Linux Kernel DPT I2O Controller Time-Of-Check Time-Of-=
Use Information Disclosure Vulnerability
      CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event
      CVE-2023-35788: net/sched: flower: fix possible OOB write infl_set_ge=
neve_opt()
    added commits:
      CIP: Bump version suffix to -cip36 after merge from stable
      arm64: dts: renesas: rzv2mevk2: Add uart0 pins
      serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
      serial: 8250_em: Use pseudo offset for UART_FCR
      serial: 8250_em: Use devm_clk_get_enabled()
      serial: 8250_em: Add missing break statement
      serial: 8250_em: Drop unused header file
      serial: 8250_em: Simplify probe()
      dt-bindings: usb: ti,hd3ss3220: Update interrupt property as optional

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


