
mkdir -p ../out/

for pop in {AFR,AMR,EAS,EUR,CSA,MID}; do

paste \
  <(zcat ../../inst/extdata/${pop}/UKBB.${pop}.l2.ldscore.gz.norsid | sed '1d' | cut -f 2) \
  <(zcat ../../inst/extdata/${pop}/UKBB.${pop}.l2.ldscore.gz | sed '1d' | cut -f 2) \
  | sort -k 1,1 \
  | join /dev/stdin \
  <(cat ../tmp/UKBB.${pop}.l2.ldscore.hg19tohg38.linker | cut -f 1,3 | sort -k 1,1) \
  | sort -V \
  | awk '{print $2,$1,$3}' \
  | tr " " "\t" \
  | sed '1s/^/rsid\thg19\thg38\n/' \
  | gzip -c > ../out/UKBB.${pop}.ldscore.linker.txt.gz

done

