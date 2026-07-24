Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57144C531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:26:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16840.1784890801463938395
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 04:00:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ewFGjBVh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1784890788;x=1786100388;bh=
	kWQvddHmZF7Ty8SRPN0yvETrjtmAVvU0Fdcdxtbcyhw=;b=ewFGjBVhUpWw/Hw6RPPPCdtIhZK7Bq
	6B0t/r25nNe0F5r8UPfH0DqgGzJFASrwJSQLSQcw254e/lHe793WJdriy0U2Wm0cJtlra9nhubsHm
	pJpBQ/ztlGkZlVVmI/8S1RiR2HaiQ6ioebt6rulwK2I8wjTsclfQRJnojlBFm/Mtv9hYp4O9vMz8s
	py0W4sobkChfXpnhbWMW1UrpNOZgaskDocr+O9r4oc9kFAEZ4Zh3GpMaS+lsQ/6UWEZcwVXtnmSAa
	M7rvtmh6RVffzUYw8TMC7d4TIeXglVybRp8wgpqPrKx4yJj7dD5XkCHxDQTuXh3Ujb0rPEMiLe6Sr
	AKgQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 66OAxlds3205376; Fri, 24 Jul 2026 19:59:47 +0900
X-Iguazu-Qid: 2yAbeCtgw5EjbQDGC1
X-Iguazu-QSIG: v=2; s=1; t=1784890787; q=2yAbeCtgw5EjbQDGC1; m=3+nScwbQepcYK0o4L0+wB/N9xLQhczZPl6uHy3xon2M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h64kp4fbfzyPQ; Fri, 24 Jul 2026 19:59:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+TnqJ85KZJBfsDOtAjVT1E/KOtTR3aFapNqsOmIYTXIckP9qbNtNdhNoBOygh2pnoBZx1ihW7LimwSw5ZO+hFHubGFmcuBZE8P4/zGh0kwur6sNQjlFBbG28Qn32sNSv7HqQff6JpSE8sEjVXnN9xxOkkCA7WmyUO87v5aOHBSE5lRp5O4Lv9JPfKJ7MyGPKm9+Eatzj4dDeRxyHt0/ihsyODERAFRKs3Vu8zLUVESUuUn5/YgYpnTn+6h3ESqiDKt5crOj4FVJtfErYsMuafZKr1zM6MFUpDFKkT3T50JSuq8aHZW7sV7IpoABfRJ3dTsWecGNyypKQJFqFEl8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH7yq0Kpt8EeN+VyNp5YbsKVBp7pRA10tPmyytHirDI=;
 b=rxKJ6IxjiLTNrCFW01N0a1k37pWJbngC0rH8ASXrMIOHruU/6DiQ/nRbcR4Qaw6ciD6W+2Qua1/dmeH3aWQs7wB4/SmvTn6atse3T5DbN5EXj1tIxkm4nLjNrnmNTqbF/DH+TinqQpGqcs4mPcGm+f6gqgdLZDJeqOIJg04noJ0B5GDwKRJtfjXZ2hT4ou/JGcgXgXUM6PpJDRc2U1EzrDPaAa69AyxDksRyXrwJ6os56FSuyPZ1Y9NnYln4eFwVnpz3OZicCC+EQHkyNGMHWFrlblb2AvI6crlKbhsxACsExbXGDQc+BaF+C+mAoZDVf/6hjg8de1EFfuJBg0Eq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>, <uli@fpond.eu>,
        <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v6.12.96-cip28
Thread-Topic: [ANNOUNCE] Release v6.12.96-cip28
Thread-Index: Ad0bW3PhtgYmlLa0Q/Sg+4tPq6LkTw==
Date: Fri, 24 Jul 2026 10:59:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189CC651603DE5C0277A39CDCF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15629:EE_
x-ms-office365-filtering-correlation-id: b61f4b61-3608-4890-0183-08dee972ab18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: 
 nCiKS9zFRs5FhxuVuxn1Y/rHN4xqUEPYTujCXrjYxAkEpc5PiLP6f6dqH916tvu4+EDUd44E7/y6ERh8W7lRQWI2aERkMu6J/DxkG6FsHlH/n/9BQRTeTMZTuOoF1iJOlbCUjjuEBg/DdZYKe/BsRTCRqo+wx8q+y2CqNKxym6XZCz0u6IDWbM81p+snSyU0YGp2oMYdhPnEPW78GKoJdPYrSuqnj7a7gbPj6SwXaHivighd+YgPMdOXY1Th1zsVNbGzJoQiPGQOIqoNAwIP2AGQpD2Xc9LC6AXvpm4OuVwCjZtLn7saxDEzJdE8f2fm70/oRGU/x0MaO4XlAPvdZELkvnC4Gz3BoyDuQcTGPQfni38X/omoJ3iEOIqdGGSD2CNsyRvERZ9u6WZjJu4m7Lpcy1LgPOsFwgfYkMx/ko86rAxec7YwVcMsHcqhV2ekHqqqrNPQ57DwF7ZfOTo6I98+/2SS3XPA5Yb3IUUpSXtmyT+iLxcMHD688oXEnQluSDBfi4EgGmXIO+kGe5qOv6z0/y7Xeu8melPnuv3Pd8yCfDEHgGt+H9bI3/Yj6IUa4dHcF2M+4aPgSWIo7XzZrvPIb/msD7yjcM/xG9HZ4aRDoQiJgs52gjBUGt++nPRkjfN0lylgF6UTvuxxTeu3cqf4r3fL75WQeosrFehlpLmRqQXjIq/U11pwFDBz2cjJgIflgxcGuZNaXe51TdbuFlr0CLpdQ9UpnWDH8hJcSO8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TEljNE9TRjZjNE1OL0J6QSthRmZEZ3BicGxLYjJKVzVESHJJelVzQjNB?=
 =?iso-2022-jp?B?NU5iNVJURm9RVzd2aGhkdHY3TXNoUUxXZXZwMTg2dEpJUHB1RDI1Mm5L?=
 =?iso-2022-jp?B?ZmJZNTh6eVBzMFJ2VjZqVXpWd29HNVhGa3lTeG5wN2hlZ0tyVkRJUHFi?=
 =?iso-2022-jp?B?MzRzbmVFOXZJQmNzT0VpZkZCRzVLKzcxais3Zi8wSkxNOVRLa0tsVmtV?=
 =?iso-2022-jp?B?SmU4ZEFuSGtZZ3RVWS8ydmV3d2JmZVdHb29keCtObWdFckZCVWY2MElz?=
 =?iso-2022-jp?B?ZExBbzZTd2Nnb29wYmFnK0lnR200blEwbXhaUUg5Rk9QcWs5MkVneVl4?=
 =?iso-2022-jp?B?Wm1kRU9VSWVKNktjUVZvMzRDVkZXTVl0bVVvVXR3bDRFT3NxblpLRG5v?=
 =?iso-2022-jp?B?NFhBY2NFVlUwZGQ0TDBpYzE5dGlJdjFsUHhFUDRtMlAvTjBIckFUSDhG?=
 =?iso-2022-jp?B?NDNGM1lQWXhOc3ZaWFdIcnBWSTdYYktxZGNGMWlNWFhjZjFIeG5wZ1ZG?=
 =?iso-2022-jp?B?NU1wMGxJNXh4RU04MVdSR2N5TENhd3N5d01QdlNSMnN1RTBNakpHaXJm?=
 =?iso-2022-jp?B?UlUzWkl6c1E4ZmJhY3ovYytsZDFGK1VRNzJvNVRoZVNTeCs4blRsbTBx?=
 =?iso-2022-jp?B?V0ppZlZjeTJQRzY4TTMxOFhKT2IyK1Q2TGM0WnVjeFlreGdTRWRMeWhN?=
 =?iso-2022-jp?B?aXphUEFORE83VTZZWWFrUmFQakdmRU85U1JPZ0c4clBORWpyZ2lBQVZK?=
 =?iso-2022-jp?B?elk0Z3dXYmZpd0xENFhvanhQdGZJRXlXODdXYjJseENpYjNYTjNFcFkr?=
 =?iso-2022-jp?B?OGplWEFRMnhwQUtLc1p6V0taMlFmZkZUQnBkcGZlbWlkamdPRUx6YmFJ?=
 =?iso-2022-jp?B?RDVzandqd0RNMEJ0ek9qazJMTkR5OVdaek0waHpCY2pFQ1RGTkt1SUpl?=
 =?iso-2022-jp?B?OWhsTEw0RnNISlRlVnExc0ozamVNQm12TDdEWjd6R3M5dlkwaDVwRElq?=
 =?iso-2022-jp?B?VzJVOGR6L01ENXBDL2FCb2JiRXNFNDFTT1dKM2QwWU5xcmdQSms3NktS?=
 =?iso-2022-jp?B?akx3YnJ2NXRDOCtTUGN2aUNPZDlhcGlxaUJKMVAwNnBpMFd3NWVHVzdq?=
 =?iso-2022-jp?B?UHVDSzh1RnNNOE02RWxpcFlEbjNHYWZ6NzgwVnFOaTVDcjI4Z2ZXeVdB?=
 =?iso-2022-jp?B?UytXTktiTTFtanZENGsxRExzS0VGWWh4Wlh0QThPMXZFRElJTHV3YXBt?=
 =?iso-2022-jp?B?cmx0VlBBb3lINCtCdnNKMmdxTWVDbkN3ZVpLT2VNdE1STGtsNjRrMjVJ?=
 =?iso-2022-jp?B?OEppb2IrL3hqb1Yyd2tJOHM5OW9MSzROMU9Na2ZicE9SOGhzQ2t6TVFQ?=
 =?iso-2022-jp?B?S1ZzL3hZemNRK0x3SndjbW9oWk1EYlhQS3BHV3NvMCt5REhhVFlDU2h0?=
 =?iso-2022-jp?B?eTJ5eU8wUkU0TUlrQ3dUSTd6OTYwNWdYbzJad0FlelZSZ3JUM1NEV20v?=
 =?iso-2022-jp?B?QnZKNVZEY283amFCMmprdi8xeUlFN0lXbkxuTjJhLzJSWmR3NjJxc081?=
 =?iso-2022-jp?B?U2I1VVRTTmxEQmowRmowa2NmQ2xhaGlkOXpSSUdrVnpvQVJZSnl5SDlj?=
 =?iso-2022-jp?B?Z3VRVVFnMDFMb1VYdGlKejBlOEkxeEc2eG9TMmxzQVVaN014MXkyNHJE?=
 =?iso-2022-jp?B?RXpSY1lnMENKRHdXSFV3bHBNblBMaTNJb2QwWVRKdWxPZFN3YS9rcHM2?=
 =?iso-2022-jp?B?ZEh3TkRoWlIrajV4QkZNUXc0OGVmMS9zdmdaZ3pvaTZxYUtwOXByQ1hp?=
 =?iso-2022-jp?B?cFFkOFBpUmRwZU1ZSHBaMEMxTU8zeEtaV2VqTWtxNGNyeDE4QzA0UlR0?=
 =?iso-2022-jp?B?VmZaWFFiZzJiOWpBQWl2TGVnNkV2SUdGMVZWazRNMkNRMzhxKzllczFv?=
 =?iso-2022-jp?B?VXJtc2xoeGlzNk5kdE5WT1V1M2tsenpKVVBDTmpIS0U3aDQxVEd1MUZt?=
 =?iso-2022-jp?B?WmF1dDhtak96cUJwenZKQ0NDNGdocjRHcFVVa1NzbXFVS3VhVkFHaUZQ?=
 =?iso-2022-jp?B?bDJ5QldnblJWVWtsQkcwZ1BwNkF0a2ZETFEwZmp5YzArTVpHZWNiajB1?=
 =?iso-2022-jp?B?R3duR3Z1a3k0NzFHWG54M2I2bHVTSHZlT3JQWTE0bEovSHZaNzV2Ti9P?=
 =?iso-2022-jp?B?eENSbk1UNm1uQnhGalpjR2tpZEkxMjAwTWFGS1hpSFhMbkdLV3YrM1pp?=
 =?iso-2022-jp?B?MVVRb3FLNzNGUGk3eFh1aXJDK01FNFFyZVFqQ2VUbHVnaWhFMVBGWW1O?=
 =?iso-2022-jp?B?Y2pVVVl3NTREZTRiWHZHNkJ2R2FlNThrOEdidTZTQ2d4allHS09mbGk3?=
 =?iso-2022-jp?B?eWw3bDAxOGVoRVUwWUJmNDBlVUtER2JldTNTcHlEREJDZU93aUk5OExy?=
 =?iso-2022-jp?B?L213UnN0aTFCd1RGd2dRdzR3VThYQ0hkblFhS3ZqOVhvNnAwY1pHY3Bi?=
 =?iso-2022-jp?B?TlI0Rmh5RGF2VkZrY0xhL0FxbDhyWGlsSVFISktrYzZHa0paUGNsT2s3?=
 =?iso-2022-jp?B?OHhlTWt6az0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QOZ54wx2xMqUs6966MTVMPUMNahRFinvHa7tWT9YB4tWhdVlyz08PV7HLkTbvNz9yr2ZbsRCC2dhVeir0bsmd3DcdrvngbHpsC5a+YclD3tk8xs49sBacj4v/R7d7hFGfFwzRQ9/EIDH2x4G8YX3KptoIl/iRF/9baiFTJ53HZGHBE+jOQg3H2oY3JwyVPhMkOzH6B4bTDw8m3hcQcau3/AmDyzZURglCydk4Oq+rNUqCG+t3SvWMfpHhoNxhnGKDfurRGNwPRjRPqZlqCX3gUv2udYgbG6biam+usrsJSPY80qVDG24J66ubDemZn2tK8WRYT05YWFO2NodaNUU7A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61f4b61-3608-4890-0183-08dee972ab18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 10:59:43.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3JA7ikCZRv4shwwLYXSHwWmVhfJHywkanZhE2z0SQMLbibZ7q0jkjY3gI8Xqfyk34yGZpLm2ZELPBpSomuXJFTUKNCWrf6S8si1H1bTOm6o/kWroRwwVuDJ8q/oMObf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15629
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 11:26:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23736

Hi all,

CIP kernel team has released Linux kernel v6.12.96-cip28.
The linux-6.12.y-cip tree has been updated base version from v6.12.95 to
v6.12.96.
And in this release, updates to temperature sensor drivers (lm75/tmp108)
adding I3C support and optimizations, alongside pinctrl extensions and DTS
updates for Renesas RZ SoCs.

Information about this release is as follows:

  v6.12.96-cip28:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      76ec98cb38f0a8ca04551274c137fb904e91b430
    fixed CVEs:
      CVE-2025-21807: block: fix queue freeze vs limits lock order in sysfs=
 store methods
      CVE-2026-46093: mm/vmalloc: take vmap_purge_lock in shrinker
      CVE-2026-53027: fs/ntfs3: fix missing run load for vcn0 in attr_data_=
get_block_locked()
      CVE-2026-53226: gpio: rockchip: fix generic IRQ chip leak on remove
      CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count
      CVE-2026-53399: nfsd: release layout stid on setlease failure
      CVE-2026-53402: fbdev: fbcon: fix out-of-bounds read in err_out of fb=
con_do_set_font()
      CVE-2026-63815: f2fs: bound i_inline_xattr_size for non-inline-xattr =
inodes
      CVE-2026-63816: f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic=
_inode
      CVE-2026-63818: f2fs: validate orphan inode entry count
      CVE-2026-64187: xfs: fail recovery on a committed log item with no re=
gions
      CVE-2026-64189: netfilter: ipset: fix race between dump and ip_set_li=
st resize
      CVE-2026-64600: xfs: resample the data fork mapping after cycling ILO=
CK
    added commits:
      CIP: Bump version suffix to -cip28 after merge from stable
      hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data
      hwmon: (lm75) add I3C support for P3T1755
      hwmon: (lm75) separate probe into common and I2C parts
      hwmon: (lm75) Remove superfluous 'client' member from private struct
      hwmon: (lm75) simplify regulator handling
      hwmon: (lm75) simplify lm75_write_config()
      hwmon: (lm75) Hide register size differences in regmap access functio=
ns
      hwmon: (lm75) Add NXP P3T1755 support
      dt-bindings: hwmon: lm75: Add NXP P3T1755
      hwmon: (tmp108) Add basic regulator support
      hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
      hwmon: (tmp108) Add support for I3C device
      hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare =
I3C support
      hwmon: (tmp108) Add NXP p3t1085 support
      dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
      arm64: dts: renesas: r9a08g046l48-smarc: Add gpio keys
      arm64: dts: renesas: rzg3l-smarc-som: Enable eth1 (GBETH1) interface
      arm64: dts: renesas: rzg3l-smarc-som: Add pinctrl configuration for E=
TH0
      arm64: dts: renesas: r9a08g046l48-smarc: Add SCIF0 pincontrol
      arm64: dts: renesas: r9a08g046: Add pincontrol node
      arm64: dts: renesas: r9a08g046: Add ICU node
      arm64: dts: renesas: Drop "syscon" fallback compatible from sysc/sys =
nodes
      arm64: dts: renesas: Add pinctrl reset-names for RZ/G2L and RZ/V2H fa=
mily SoCs
      pinctrl: renesas: rzg2l: Add support for clone channel control
      mfd: syscon: Allow syscon nodes without a "syscon" compatible
      pinctrl: renesas: rzg2l: Simplify rzg2l_pinctrl_set_mux()
      pinctrl: renesas: rzg2l: Add support for RZ/G3L SoC
      pinctrl: renesas: rzg2l: Update OEN pin validation to use exact match
      pinctrl: renesas: rzg2l: Add support for selecting power source for {=
WDT,AWO,ISO}
      pinctrl: renesas: rzg2l: Make QSPI register handling conditional
      pinctrl: renesas: rzg2l: Handle PUPD for RZ/V2H(P) dedicated pins in =
PM
      pinctrl: renesas: rzg2l: Add NOD register cache for PM suspend/resume
      pinctrl: renesas: rzg2l: Handle RZ/V2H(P) IOLH configuration in PM ca=
che
      pinctrl: renesas: rzg2l: Add SR register cache for PM suspend/resume
      pinctrl: renesas: rzg2l: Fix SMT register cache handling
      pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
      dt-bindings: pinctrl: renesas: Document RZ/G3L SoC
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document reset-names
      arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
      arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes

Best regards,
  Nobuhiro


