class ArmEabiBinutils < Formula
  desc "GNU binutils for arm-eabi"
  homepage "https://www.gnu.org/software/binutils/"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.35.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.35.1.tar.xz"
  sha256 "3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607"

  def install
    system "./configure", "--target=arm-eabi",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}/arm-eabi-binutils",
                          "--disable-nls"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test-s.s").write <<~EOS
      .section .data
      .section .text
      .globl _start
      _start:
          mov r5, #0
	      mov r6, #0
    EOS
    system "#{bin}/arm-eabi-as", "-o", "test-s.o", "test-s.s"
    assert_match "file format elf32-littlearm",
      shell_output("#{bin}/arm-eabi-objdump -a test-s.o")
  end
end
