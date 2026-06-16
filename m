Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27506CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 12:38:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.153425.1781613489565911939
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 05:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bprZY0r+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1781613473;x=1782823073;bh=
	Yw6ldmbCqsHUvQsMniwm4XsWSsN+BUsjP6nf1nTLxzE=;b=bprZY0r+z2bAzsyQb91+bubFhKAuxu
	lW2bROenHL2zNvkHY3XIhob2SjHyBbRL/7/6z5bdjGCFGprsldAq3wla1gOt0kfJR0rbVDVWHvmXT
	fJmt/uQWlUDeZBXGhs5pWUtWGs2VJ3TpR3YIeWxAeFh4RrN3qoqW+C6VaFdcsQF1y6hxAZ/OQbLaL
	VSrKKRux3COsuR27sgZZnAlowz19vkLQUBmdyOt3dZmcCmnZXugSmhiwGPsk6qe1iUkpITSI7Bdk7
	6PP1EPjskr7PYIB6ffZ9iOEGeex/OMhJqLW/O6r3AheO/BbYbHCiU/rxTC1UKgNUzV7awuBU0i0IR
	KySg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 65GCbqua3844552; Tue, 16 Jun 2026 21:37:52 +0900
X-Iguazu-Qid: 2rWhVaVmInpReRWbxo
X-Iguazu-QSIG: v=2; s=0; t=1781613472; q=2rWhVaVmInpReRWbxo; m=FXARMVeMWTa2RY65cMLeBisGmGQze41zg8LrzPDW6XY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfmjW0Pdcz1xnj; Tue, 16 Jun 2026 21:37:51 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSE6AKVd4gVXvQL03LsIFRQkp5Z44WVzT8xSqHhmDru16gPx4gSJswDAMWRAU5/ywA934oOnh6cqRj6e+l1DFvmCFaFPK4I2EWWmP+yqboQTLUVO9OU9BITUDQ2wMtyIxx4M08WWqOhesfO5iN+Gzkpjzixai4/s9A3srIgCsq72bX4EeBOG1jA4GStFJT+GMr1iOn3hSN9HEj2BlWfFzQI92TTdxMLypo5LQjyu/t5epXsrETfZdVC2HcU+zLOPn7DGA5Ma7i3PD/nooIKELYjrx50Pn92JMc/M2YCKViOkkcunADH8Z871h33dHRva17CDTLLQAmMtRnfSOUtn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNF+W5xWxhjTjfAdTOLe1NWpOjv3YkLF7bY1zwsNBIw=;
 b=eXDVWQvxP44ty0h5oXi+YfkUATaYFDDLXk2ekSB/DWoii0IY99jOMpRL2W7Pa4tbsoR2Y1BVGxd7lYNZFE+YvC2m16m3+5OXYwFXiJJZ9vBjykxqTsynMUJA2Q1h+AZxq/LWeePz1wusvnHbZ/P96coJ3YUCdR5lzc+in7NoI0ZDZ4E+11KS2cNcQ90/onPuiV/kO05Q8RPT3GmL6th7AAkXfhyRhwUoZnptHRNA9CYOAyR/N1gqeMmKTaVf0gle+YGBEUaSfHqqzfwDerMHQEaX1zmrfyYmuyLwJZeG7E8cRIhqvQOh02SpttHx7vIHnjJ1ms4SgRHvyAiY6qOmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.175-cip57
Thread-Topic: [ANNOUNCE] Release v6.1.175-cip57
Thread-Index: Adz9jN4O9QpJ9LSORGa7DywWI+fXIg==
Date: Tue, 16 Jun 2026 12:37:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481849ABEF1A9622B6786F8DCDE52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10749:EE_
x-ms-office365-filtering-correlation-id: d968a52d-2430-4338-0281-08decba4105f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|18002099003|18092099006|3023799007|38070700021;
x-microsoft-antispam-message-info: 
 c7510xNIll/+oBLaR/IYd30JfOo6/yfgj+7zg0quj2wO722XjQsnGR+vaqPCVVDamcevv1alTm/yhoRMTrDSQX1/pJ/rw3TTPmD+b1Llfem8GjUMQff2FaMnbd9DA8xCq5wsBRcxq/tALjTrGcoWbXn0WUnq8OL3n10uIo76crctwDKfcTo2Et0HeUBnnVN12x09mpQDCk60JKszJGTgdHoqCCfgq+hWjoF6nIMqXjCj9zQTOjYbYLK9YgsWlj08rhG81U9DjiFchww4FO5G4mRkDOgMmw45BJf3v9lnzFdmoudBoSV5ByCn3rxMZfHIHZx9NRJrGS3Ef9OkAInx87RtfAoeEipUzxPM5Yq8nJuF49FDSW+R37wCGYilGftmvCoYOavTWnxfPA9QKlkY1w1pr05659JCjrnFvy5ubdzwYuIaZiTo1M0gZ9T4368SAGQzBmmaLjYaqjrV6v4hgVfR+0hiHBP1GpEP4x3vjgszrXAy5u7VLpFYurSXteyxbzW1iLu2+LyiOBxyd0x2khLdHtWBuwrFkzpnKIBhRKouV3/DInb8i0wGK2KOKW4AKNis5CCrbTM/HMvNWrKh54JNvSowVl2UErd7ijtOgtiprC4AZFuFs+ZZEBGxE2yL+wRJu+Ue6j5m6YBHsKqPLuucKdullGN86GqzLoy4zSEZoiszFFLEC7G9vadho6kzXheuRn2h5arSL2j/EccJTlX95yapTytzE4Na3fbUTH3FTLSh5fVgDGaazwrbck5N
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(18092099006)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Sk9pQnpWSTROUzZpdmc5bWo2ZWRaakRkUW9BSFJ0UDNhRk1YVHF0cUNu?=
 =?iso-2022-jp?B?TitzaWhhcWp3dGwyUHFBclRDV2cwU2I5TjdrY1pHNnZXTjZxUnF1ekxD?=
 =?iso-2022-jp?B?M2UrdUM4cExIWDFtSDNTOWFkVG5ONVlrOGFXTjFkalVtVE1HMDRtZVd2?=
 =?iso-2022-jp?B?WW1Ra3Fmb0h3UHNVNDR3V0lWdjVvWUxNbmRUZHAxNW95c2VkekJ3Q01k?=
 =?iso-2022-jp?B?V0JwcGhjT0FuaVlMenlVUDl1WUdYdE5OODYyWUZ3bGEybTFlQ2p6cyts?=
 =?iso-2022-jp?B?a3NMUjhsUm1zQm1XcnA3bjJaMVpjZ0lMclpyWXl3VFZ3WVAySy83aG15?=
 =?iso-2022-jp?B?OUtxRzBIaDd0dWVuSnh0RzRIZUk0TUtMWmQzTnNmUSt3blFybEV5Tk92?=
 =?iso-2022-jp?B?dHlEK3NwbldtT2E4V0NkRjIzME9Ec2htMG9BR28xMXZLVURQem9HV3RV?=
 =?iso-2022-jp?B?NEN6NzJLR004eXVoSFd0RUFPUytkbVRqaXBoNERjai9xYzR2Tld4VUNh?=
 =?iso-2022-jp?B?YjVYQkxwSXExRzUxQnRqVUVuM0FNM1hXbTFVK3ZUY0ovYnlac3BYUTky?=
 =?iso-2022-jp?B?Q0w5YVEyMkMzU2xINFFWcjF0OG42ZVo0LzBxMWczMG1ZaG9Bb2VINGZQ?=
 =?iso-2022-jp?B?cDJWQlF3ZXVoS1psNnExcERsbWVGb09kUng1NVpIUnhCZ2pNcnM2anlD?=
 =?iso-2022-jp?B?M1FYclg4WTJBaTEyb1VsN3owTGpSNEtUcDM5QlVKUndnaG0wOU4vNWFl?=
 =?iso-2022-jp?B?WDFqQ2FEU3l2TjRFTzVHak1ycUpOa3FhY2FQQ0hBK3pjeTVoamQvS3Zv?=
 =?iso-2022-jp?B?OTZENXRCSFlyTWRkcUtZMVIrOU1pbitWd21icmFKMWdHTmdReHEwekIv?=
 =?iso-2022-jp?B?eEFuUVlRdGtSM0FEcWpxbHFPNXp5c0w0MjVaeXVrSDZ3K2pJTWRYWWtE?=
 =?iso-2022-jp?B?ZDNFVWEvRmdsVDNyb0dyYVJ2aENVOEFoQnZnZmNQSWJpR2NLOEE3VVk5?=
 =?iso-2022-jp?B?NFllZnpwRi92NVBtOWFOZjJpUjltdkdSMGQ4NlhDZ2hobzVPeU13bzBN?=
 =?iso-2022-jp?B?aWJrbllLYUZtTmtkSUJKUC9pU1pYenh3dVgvZzYvbWg1Yk4vaUpjdjhz?=
 =?iso-2022-jp?B?emw0OHY4Vmh2Y3EyTnFFZ09MS1ZpNDZUTDF5Uy9ZU0JoZGFZN0hacTFG?=
 =?iso-2022-jp?B?K3VNM21GNVNBSXpIc3FleFdlVDJmT1BDa0JsbkJKUXFvWmZpUm13ek5p?=
 =?iso-2022-jp?B?TWd5NlhjZEdvRzJLa0lqbGF0YlRPblBoekJ1cHQ4aFRKUHZNV2NSb1Zt?=
 =?iso-2022-jp?B?NUhhZWlTbjduK1Z0Z3NHOHZYMXBJWHgzSjdpN0RrSTNTZGhsSUdLb1VM?=
 =?iso-2022-jp?B?dHJleThhaXdsdmFERlpjdDJiWUR0eVdyQ2NlZVMzMVlzaXp3SHg3bTVy?=
 =?iso-2022-jp?B?RENJWkVIWkFTQzhYdjBBNWpCOTBsTFIyZ2E0VnlsR2dHUUI0eHlsdnpN?=
 =?iso-2022-jp?B?V25NeEJrM1BOaUhqaDAybjZEKys5L0xQLzZqRDBTT0VCcEVTS3J5TU9y?=
 =?iso-2022-jp?B?QW0xVEdzUlFoL0ZBQVpGeWpPc1VIVkQvaDJKVm1UZzQyUFUyOExxUHNO?=
 =?iso-2022-jp?B?dSthQW5uc0g2QVNhT0RuTHJUT0l1YjFwRXdlaitSOXRXY3FHZUtFRTdP?=
 =?iso-2022-jp?B?NHZtdnJwd2tKYnZtZlVQdlJsTEx0MFdYWFJGYk9SU1lvczNjQXJuTHhY?=
 =?iso-2022-jp?B?cGJwVjRYRnlkeldtYmV2SnllWU44c3NNUHczNzJpejdhZUJoWnVWcUp5?=
 =?iso-2022-jp?B?U0lFaUNZYkFldmxYNGgvTG1ZRTJBMXE1SVRMZWYrOGRDSWVnYkpXUUd3?=
 =?iso-2022-jp?B?OE45UGlvTVdzTHVvT3pQTWFIOXdISmpvd1VhT3BOdkxOTlNQMUtvanZ2?=
 =?iso-2022-jp?B?ZWxwaE1MNUQwTStzcGF5Mis0cGVVbm1PNjRibDR6Z21MdTI0YWVjM0VX?=
 =?iso-2022-jp?B?TStMRWdVM2QweWNCejM0cmtsdmJLdVdCNE9PdW9UOEdYVEtUSjNtSWJ0?=
 =?iso-2022-jp?B?dUs3RnRXSDFiTTNacmEva0ltaXRwL3dsVDZ5UzNENWhrZmRQRksrVjJ3?=
 =?iso-2022-jp?B?Y1pxbk5udE0zeVA1NkVSc285b05CUGdubVRveEIxRWtOUlpmUHd0TVVn?=
 =?iso-2022-jp?B?VTZjVXQ2WEpNSG1vUlhwWmRubUVOQmU5dnFjV3JES2xDSG9ZcG5kL2l5?=
 =?iso-2022-jp?B?OXN5cVArcVQrUWo4V1pOMjJ1ajlmTlkwR2pDSHNPekgweVE0WWlwKzcw?=
 =?iso-2022-jp?B?TUR5RnRNMEFnR0dkS2p4bW1iVEw1RkFHbzAzSDdjS0ZQNDNnYTZTQVdP?=
 =?iso-2022-jp?B?OTRrcjg4akNtMUNqWXF5YkNPRE5DeWxtOGx0RDl6cithR2tyWHNYVFBN?=
 =?iso-2022-jp?B?YjkwR0x1eUdramg0dHdJZVFLd3lhNER4Y295RnptS2llNjM1YlovQUVJ?=
 =?iso-2022-jp?B?R3kxRHJEcmtKV1lZOWt2d1ZzYjBKeU44L2Vpa3ZFbWFtdi9TMHpoZHlR?=
 =?iso-2022-jp?B?TmdXUytSUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	PlTDNb3xLJo/uRVLAxppJGwsPl8yJtcDIDgN3dCS8n84H8I0Z6kcfpW2qqqTe/B0INmLJhIjdI4xZhwltVpjwDncksfHu/klRDkw2FUvr/k19actavaVxC/DfnYobULfDuZd4n2mudeqqeM4DjUcSXe6Nd2cMI4hA6JDgAYtzQG8AIoJBGGezM0dXIXdtASFhuVNRZcP7K/GnI2kc5MF4MyCmMIL30Q0I8gPHtGdCd6vzh5ekzdOBaa84ykxlafUa1UmeyI90Lhlsgwa/CfBtvxT1KKsjz3nh+nPuI4U8JWLjijZzCzJPgnuRp018ERwDOI5Ca47Kh/UVtvRjy1m8w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968a52d-2430-4338-0281-08decba4105f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 12:37:44.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGtDRRUvijNQDYDAM+n8CYX15wc+Jreh0bw7Hwfsf0FMAN2lMhrsIyOQ8Ajnxw4UXT3M7Z8ERZezTs8AialNB4BDeXJtkNUuVnPZEuNo+5TLggBTpufAvjyPBhNvCjqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10749
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 12:38:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23155

Hi all,

CIP kernel team has released Linux kernel v6.1.175-cip57.
The linux-6.1.y-cip tree has been updated base version from v6.1.173 to v6.=
1.175.
This release includes an update for the PCIe host controller for Renesas AR=
M64 SoCs.

Information about this release is as follows:

  v6.1.175-cip57:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      deb4e6b289ac7da3cec9f433bf1c66495c70f0fc
    fixed CVEs:
      CVE-2026-43503: net: skbuff: propagate shared-frag marker through fra=
g-transfer helpers
      CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class
      CVE-2023-53292: blk-mq: fix NULL dereference on q->elevator in blk_mq=
_elv_switch_none
      CVE-2023-53989: arm64: mm: fix VA-range sanity check
      CVE-2023-54322: arm64: set __exception_irq_entry with __irq_entry as =
a default
      CVE-2024-36922: wifi: iwlwifi: read txq->read_ptr under lock
      CVE-2024-53221: f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
      CVE-2024-56647: net: Fix icmp host relookup triggering ip_rt_bug
      CVE-2024-56657: ALSA: control: Avoid WARN() for symlink errors
      CVE-2025-21739: scsi: ufs: core: Fix use-after free in init error and=
 remove paths
      CVE-2025-21845: mtd: spi-nor: sst: Fix SST write failure
      CVE-2025-21847: ASoC: SOF: stream-ipc: Check for cstream nullity in s=
of_ipc_msg_data()
      CVE-2025-21863: io_uring: prevent opcode speculation
      CVE-2025-22105: bonding: check xdp prog when set bond mode
      CVE-2025-37864: net: dsa: clean up FDB, MDB, VLAN entries on unbind
      CVE-2025-38584: padata: Fix pd UAF once and for all
      CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_fr=
ee_dic
      CVE-2025-38710: gfs2: Validate i_depth for exhash directories
      CVE-2025-39997: ALSA: usb-audio: fix race condition to UAF in snd_usb=
midi_free
      CVE-2025-40347: net: enetc: fix the deadlock of enetc_mdio_lock
      CVE-2025-68201: drm/amdgpu: remove two invalid BUG_ON()s
      CVE-2025-68315: f2fs: fix to detect potential corrupted nid in free_n=
id_list
      CVE-2025-68823: ublk: fix deadlock when reading partition table
      CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue
      CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype
      CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()
      CVE-2026-23399: nf_tables: nft_dynset: fix possible stateful expressi=
on memleak in error path
      CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths
      CVE-2026-23444: wifi: mac80211: always free skb on ieee80211_tx_prepa=
re_skb() failure
      CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent reso=
urce exhaustion
      CVE-2026-31407: netfilter: conntrack: add missing netlink policy vali=
dations
      CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_index=
es
      CVE-2026-31488: drm/amd/display: Do not skip unrelated mode changes i=
n DSC validation
      CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path
      CVE-2026-31500: Bluetooth: btintel: serialize btintel_hw_error() with=
 hci_req_sync_lock
      CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()
      CVE-2026-31576: media: hackrf: fix to not free memory after the devic=
e is registered in hackrf_probe()
      CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in nilfs_m=
dt_save_to_shadow_map
      CVE-2026-31578: media: as102: fix to not free memory after the device=
 is registered in as102_usb_probe()
      CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and cras=
h
      CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect
      CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open=
()
      CVE-2026-31585: media: vidtv: fix nfeeds state corruption on start_st=
reaming failure
      CVE-2026-31586: KVM: SEV: Protect *all* of sev_mem_enc_register_regio=
n() with kvm->lock
      CVE-2026-31587:  ASoC: qcom: q6apm: move component registration to un=
managed version
      CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold =
small write values
      CVE-2026-31590: KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCR=
YPT_REG_REGION
      CVE-2026-31594: PCI: endpoint: pci-epf-vntb: Remove duplicate resourc=
e teardown
      CVE-2026-31595: PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in=
 epf_ntb_epc_cleanup
      CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend
      CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FA=
ULT_RETRY
      CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_e=
nd_io_write
      CVE-2026-31599: media: vidtv: fix NULL pointer dereference in vidtv_c=
hannel_pmt_match_sections
      CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page
      CVE-2026-31603: staging: sm750fb: fix division by zero in ps_to_hz()
      CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREEN=
INFO
      CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_=
submit()
      CVE-2026-31611: ksmbd: require 3 sub-authorities before reading sub_a=
uth[2]
      CVE-2026-31612: ksmbd: validate EaNameLength in smb2_get_ea()
      CVE-2026-31613: smb: client: fix OOB reads parsing symlink error resp=
onse
      CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in=
 standard request handlers
      CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in pn=
_rx_complete()
      CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in ncm=
_unwrap_ntb()
      CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREE=
NINFO
      CVE-2026-31619: ALSA: fireworks: bound device-supplied status before =
string array lookup
      CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD=
 response handler
      CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_=
complete()
      CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid und=
efined shift
      CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_e=
vent()
      CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_ve=
rify()
      CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message bef=
ore using it
      CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED check=
s
      CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output
      CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets
      CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion
      CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_loc=
k
      CVE-2026-31676: rxrpc: only handle RESPONSE during service challenge
      CVE-2026-31681: netfilter: xt_multiport: validate range encoding in c=
heckentry
      CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers
      CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for =
all packets
      CVE-2026-31686: mm/kasan: fix double free for kasan pXds
      CVE-2026-31694: fuse: reject oversized dirents in page cache
      CVE-2026-31696: rxrpc: Fix missing validation of ticket length in non=
-XDR key preparsing
      CVE-2026-31697: crypto: ccp: Don't attempt to copy ID to userspace if=
 PSP command failed
      CVE-2026-31698: crypto: ccp: Don't attempt to copy PDH cert to usersp=
ace if PSP command failed
      CVE-2026-31699: crypto: ccp: Don't attempt to copy CSR to userspace i=
f PSP command failed
      CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in cr=
eate_card()
      CVE-2026-31702: f2fs: fix use-after-free of sbi in f2fs_compress_writ=
e_end_io()
      CVE-2026-31704: ksmbd: use check_add_overflow() to prevent u16 DACL s=
ize overflow
      CVE-2026-31705: ksmbd: fix out-of-bounds write in smb2_get_ea() EA al=
ignment
      CVE-2026-31708: smb: client: fix OOB read in smb2_ioctl_query_info QU=
ERY_INFO path
      CVE-2026-31711: smb: server: fix active_num_conn leak on transport al=
location failure
      CVE-2026-31716: fs/ntfs3: validate rec->used in journal-replay file r=
ecord check
      CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_ope=
r
      CVE-2026-43058: media: vidtv: fix pass-by-value structs causing MSAN =
warnings
      CVE-2026-43071: dcache: Limit the minimal number of bucket to two
      CVE-2026-43072: drm/vc4: platform_get_irq_byname() returns an int
      CVE-2026-43074: eventpoll: defer struct eventpoll free to RCU grace p=
eriod
      CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inl=
ine
      CVE-2026-43076: ocfs2: validate inline data i_size during inode read
      CVE-2026-43079: perf/x86/intel/uncore: Skip discovery table for offli=
ne dies
      CVE-2026-43080: l2tp: Drop large packets with UDP encap
      CVE-2026-43085: netfilter: nfnetlink_log: initialize nfgenmsg in NLMS=
G_DONE terminator
      CVE-2026-43089: xfrm_user: fix info leak in build_mapping()
      CVE-2026-43093: xsk: tighten UMEM headroom validation to account for =
tailroom and min frame
      CVE-2026-43094: ixgbevf: add missing negotiate_features op to Hyper-V=
 ops table
      CVE-2026-43098: nfc: s3fwrn5: allocate rx skb before consuming bytes
      CVE-2026-43099: ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
      CVE-2026-43103: net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      CVE-2026-43104: drm/vc4: Fix a memory leak in hang state error path
      CVE-2026-43105: drm/vc4: Fix memory leak of BO array in hang state
      CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events
      CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_even=
t
      CVE-2026-43112: fs/smb/client: fix out-of-bounds read in cifs_sanitiz=
e_prepath
      CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_=
frames
      CVE-2026-43114: netfilter: nft_set_pipapo_avx2: don't return non-matc=
hing entry on expiry
      CVE-2026-43117: btrfs: tracepoints: get correct superblock from dentr=
y in event btrfs_sync_file()
      CVE-2026-43350: smb: client: require a full NFS mode SID before readi=
ng mode bits
      CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests
      CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails
      CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with =
peek and qdisc_dequeue_peeked
      CVE-2026-43497: fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent =
use-after-free
      CVE-2026-43499: rtmutex: Use waiter::task instead of current in remov=
e_waiter()
      CVE-2026-43501: ipv6: rpl: reserve mac_len headroom when recompressed=
 SRH grows
      CVE-2026-43502: net/rds: handle zerocopy send cleanup before the mess=
age is queued
      CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_st=
ate_change_cb()
      CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_ne=
w_connection_cb()
      CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_ge=
t_sndtimeo_cb()
      CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_=
next_key()
      CVE-2026-45839: bpf: reject negative CO-RE accessor indices in bpf_co=
re_parse_spec()
      CVE-2026-45840: openvswitch: cap upcall PID array size and pre-size v=
port replies
      CVE-2026-45841: netfilter: nfnetlink_osf: fix divide-by-zero in OSF_W=
SS_MODULO
      CVE-2026-45842: slip: reject VJ receive packets on instances with no =
rstate array
      CVE-2026-45843: slip: bound decode() reads against the compressed pac=
ket length
      CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsi=
ng
      CVE-2026-45846: bareudp: fix NULL pointer dereference in bareudp_fill=
_metadata_dst()
      CVE-2026-45986: crypto: ccree - fix a memory leak in cc_mac_digest()
      CVE-2026-45987: KVM: nSVM: Sync interrupt shadow to cached vmcb12 aft=
er VMRUN of L2
      CVE-2026-45992: [REJECTED]: ALSA: caiaq: Fix potentially leftover ep1=
_in_urb at error path
      CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to mi=
ssing size checks
      CVE-2026-45997: scsi: sd: fix missing put_disk() when device_add(&dis=
k_dev) fails
      CVE-2026-46002: ext2: reject inodes with zero i_nlink and valid mode =
in ext2_iget()
      CVE-2026-46004: ALSA: caiaq: Handle probe errors properly
      CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds=
 check
      CVE-2026-46009: PCI: endpoint: pci-epf-ntb: Remove duplicate resource=
 teardown
      CVE-2026-46015: tcp: call sk_data_ready() after listener migration
      CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RA=
TES
      CVE-2026-46019: crypto: atmel-aes - Fix 3-page memory leak in atmel_a=
es_buff_cleanup
      CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mous=
e_interrupt()
      CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()
      CVE-2026-46024: libceph: Prevent potential null-ptr-deref in ceph_han=
dle_auth_reply()
      CVE-2026-46027: net/smc: avoid early lgr access in smc_clc_wait_msg
      CVE-2026-46031: net: ks8851: Reinstate disabling of BHs around IRQ ha=
ndler
      CVE-2026-46033: crypto: authencesn - reject short ahash digests durin=
g instance creation
      CVE-2026-46037: ipv4: icmp: validate reply type before using icmp_poi=
nters
      CVE-2026-46040: inotify: fix watch count leak when fsnotify_add_inode=
_mark_locked() fails
      CVE-2026-46043: RDMA/rxe: Validate pad and ICRC before payload_size()=
 in rxe_rcv
      CVE-2026-46046: ext4: fix missing brelse() in ext4_xattr_inode_dec_re=
f_all()
      CVE-2026-46047: net: qrtr: ns: Fix use-after-free in driver remove()
      CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failu=
re
      CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF
      CVE-2026-46050: md/raid10: fix deadlock with check operation and nowa=
it requests
      CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()
      CVE-2026-46053: net: rds: fix MR cleanup on copy error
      CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passke=
y handlers
      CVE-2026-46058: media: amphion: Fix race between m2m job_abort and de=
vice_run
      CVE-2026-46062: ntfs3: fix integer overflow in run_unpack() volume bo=
undary check
      CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message=
()
      CVE-2026-46070: md/raid5: validate payload size before accessing jour=
nal metadata
      CVE-2026-46072: ntfs3: add buffer boundary checks to run_unpack()
      CVE-2026-46075: crypto: atmel-sha204a - Fix potential UAF and memory =
leak in remove path
      CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction
      CVE-2026-46078: erofs: fix the out-of-bounds nameoff handling for tra=
iling dirents
      CVE-2026-46079: rbd: fix null-ptr-deref when device_add_disk() fails
      CVE-2026-46080: ocfs2: split transactions in dio completion to avoid =
credit exhaustion
      CVE-2026-46082: KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=3D0
      CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in s=
nd_ctl_elem_init_enum_names()
      CVE-2026-46092: wifi: rtw88: check for PCI upstream bridge existence
      CVE-2026-46098: net: caif: clear client service pointer on teardown
      CVE-2026-46099: net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnel=
s
      CVE-2026-46101: netfilter: reject zero shift in nft_bitwise
      CVE-2026-46102: net: strparser: fix skb_head leak in strp_abort_strp(=
)
      CVE-2026-46103: can: ucan: fix devres lifetime
      CVE-2026-46107: dm-thin: fix metadata refcount underflow
      CVE-2026-46108: ipmi:si: Return state to normal if message allocation=
 fails
      CVE-2026-46109: usb: ulpi: fix memory leak on ulpi_register() error p=
aths
      CVE-2026-46112: RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
      CVE-2026-46113: KVM: x86: Fix shadow paging use-after-free due to une=
xpected GFN
      CVE-2026-46119: libceph: Fix slab-out-of-bounds access in auth messag=
e processing
      CVE-2026-46120: ip6_gre: Use cached t->net in ip6erspan_changelink().
      CVE-2026-46122: wifi: b43: enforce bounds check on firmware key index=
 in b43_rx()
      CVE-2026-46123: Bluetooth: virtio_bt: clamp rx length before skb_put
      CVE-2026-46124: isofs: validate block number from NFS file handle in =
isofs_export_iget
      CVE-2026-46127: RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdm=
a_copy_pd_uresp()
      CVE-2026-46128: ipmi: Check event message buffer response for bad dat=
a
      CVE-2026-46129: btrfs: fix double free in create_space_info() error p=
ath
      CVE-2026-46132: net: rtnetlink: zero ifla_vf_broadcast to avoid stack=
 infoleak in rtnl_fill_vfinfo
      CVE-2026-46133: RDMA/rxe: Reject unknown opcodes before ICRC processi=
ng
      CVE-2026-46136: wifi: mt76: mt7921: fix a potential clc buffer length=
 underflow
      CVE-2026-46143: ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
      CVE-2026-46146: ALSA: usb-audio: Avoid potential endless loop in conv=
ert_chmap_v3()
      CVE-2026-46149: scsi: target: configfs: Bound snprintf() return in tg=
_pt_gp_members_show()
      CVE-2026-46150: fanotify: fix false positive on permission events
      CVE-2026-46151: usb: usblp: fix heap leak in IEEE 1284 device ID via =
short response
      CVE-2026-46156: LoongArch: Fix potential ADE in loongson_gpu_fixup_dm=
a_hang()
      CVE-2026-46161: md/raid10: fix divide-by-zero in setup_geo() with zer=
o far_copies
      CVE-2026-46163: wifi: b43legacy: enforce bounds check on firmware key=
 index in RX path
      CVE-2026-46165: openvswitch: vport: fix self-deadlock on release of t=
unnel ports
      CVE-2026-46167: usb: usblp: fix uninitialized heap leak via LPGETSTAT=
US ioctl
      CVE-2026-46168: mptcp: fix scheduling with atomic in timestamp sockop=
t
      CVE-2026-46172: ipv6: xfrm6: release dst on error in xfrm6_rcv_encap(=
)
      CVE-2026-46173: exit: prevent preemption of oopsing TASK_DEAD task
      CVE-2026-46177: ipmi: Add limits to event and receive message request=
s
      CVE-2026-46178: RDMA/mlx4: Fix resource leak on error in mlx4_ib_crea=
te_srq()
      CVE-2026-46179: ASoC: SOF: Don't allow pointer operations on unconfig=
ured streams
      CVE-2026-46184: sound: ua101: fix division by zero at probe
      CVE-2026-46185: smb/client: fix out-of-bounds read in symlink_data()
      CVE-2026-46186: Bluetooth: virtio_bt: validate rx pkt_type header len=
gth
      CVE-2026-46187: wifi: rsi: fix kthread lifetime race between self-exi=
t and external-stop
      CVE-2026-46189: RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucon=
text() error path
      CVE-2026-46197: drm/amdkfd: validate SVM ioctl nattr against buffer s=
ize
      CVE-2026-46198: batman-adv: fix integer overflow on buff_pos
      CVE-2026-46199: drm/amdgpu/vcn4: Prevent OOB reads when parsing dec m=
sg
      CVE-2026-46205: staging: media: atomisp: Disallow all private IOCTLs
      CVE-2026-46206: batman-adv: reject new tp_meter sessions during teard=
own
      CVE-2026-46209: drm/gem: Fix inconsistent plane dimension calculation=
 in drm_gem_fb_init_with_funcs()
      CVE-2026-46212: batman-adv: bla: prevent use-after-free when deleting=
 claims
      CVE-2026-46214: vsock/virtio: fix accept queue count leak on transpor=
t mismatch
      CVE-2026-46218: drm/amdgpu: Add bounds checking to ib_{get,set}_value
      CVE-2026-46219: spi: mpc52xx: fix use-after-free on unbind
      CVE-2026-46220: drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fenc=
e emission
      CVE-2026-46227: sctp: revalidate list cursor after sctp_sendmsg_to_as=
oc() in SCTP_SENDALL
      CVE-2026-46230: drm/amdgpu/vcn3: Prevent OOB reads when parsing dec m=
sg
      CVE-2026-46231: batman-adv: bla: put backbone reference on failed cla=
im hash insert
      CVE-2026-46233: batman-adv: bla: only purge non-released claims
      CVE-2026-46234: vsock: fix buffer size clamping order
      CVE-2026-46235: media: saa7164: add ioremap return checks and cleanup=
s
      CVE-2026-46236: media: rc: xbox_remote: heed DMA restrictions
      CVE-2026-46238: batman-adv: stop caching unowned originator pointers =
in BAT IV
      CVE-2026-46243: smb: client: reject userspace cifs.spnego description=
s
      CVE-2026-46273: ibmveth: Disable GSO for packets with small MSS
      CVE-2026-46275: Bluetooth: hci_uart: fix UAFs and race conditions in =
close and init paths
      CVE-2026-46276: drm/amdgpu: fix zero-size GDS range init on RDNA4
      CVE-2026-46285: mtd: docg3: fix use-after-free in docg3_release()
      CVE-2026-46293: clk: microchip: mpfs-ccc: fix out of bounds access du=
ring output registration
      CVE-2026-46294: dm: fix a buffer overflow in ioctl processing
      CVE-2026-46301: spi: topcliff-pch: fix use-after-free on unbind
      CVE-2026-46303: isofs: validate Rock Ridge CE continuation extent aga=
inst volume size
      CVE-2026-46304: nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_f=
ree
      CVE-2026-46306: flow_dissector: do not dissect PPPoE PFC frames
      CVE-2026-46307: wifi: ath5k: do not access array OOB
      CVE-2026-46319: net/sched: act_ct: Only release RCU read lock after c=
t_ft
    added commits:
      CIP: Bump version suffix to -cip57 after merge from stable
      i2c: riic: Implement bus recovery
      PCI: rzg3s-host: Revert generic field helpers, use a local field_prep=
()
      arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
      arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
      arm64: dts: renesas: r9a09g047: Add PCIe node
      PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
      PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
      PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
      PCI: rzg3s-host: Add SoC-specific configuration and initialization ca=
llbacks
      PCI: rzg3s-host: Make configuration reset lines optional
      PCI: rzg3s-host: Make SYSC register offsets SoC-specific
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
      PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3=
E SoC
      PCI: rzg3s-host: Reorder reset assertion during suspend
      PCI: rzg3s-host: Fix reset handling in probe error path
      bitfield: Add non-constant field_{prep,get}() helpers
      bitfield: Add less-checking __FIELD_{GET,PREP}()
      clk: renesas: r9a09g047: Add PCIe clocks and reset

Best regards,
  Nobuhiro


