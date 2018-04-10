#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

void print_children(PDFOutline *outline) {
  for (int i = 0; i < [outline numberOfChildren]; ++i) {
    PDFOutline *child = [outline childAtIndex:i];
    printf("\t%s\n", [[child label] cStringUsingEncoding:NSUTF8StringEncoding]);
  }
}

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    if ([arguments count] != 2) {
      fprintf(stderr, "Usage:\npdfoutline <pdf-file>\n");
      exit(1);
    } else {
      NSURL *pdfFile = [NSURL fileURLWithPath:arguments[1]];
      if (!pdfFile) {
        fprintf(stderr, "Error creating URL\n");
        exit(1);
      }
      PDFDocument *doc = [[PDFDocument alloc] initWithURL:pdfFile];
      if (!doc) {
        fprintf(stderr, "Error creating document\n");
        exit(1);
      }
      PDFOutline *outline = [doc outlineRoot];
      if (!outline) {
        fprintf(stderr, "Error getting outline\n");
        exit(1);
      }

      for (int i = 0; i < [outline numberOfChildren]; ++i) {
        PDFOutline *child = [outline childAtIndex:i];
        printf("%s\n", [[child label] cStringUsingEncoding:NSUTF8StringEncoding]);
        print_children(child);
      }
    }
  }
  return 0;
}
